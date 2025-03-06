this.perk_rf_flail_spinner <- ::inherit("scripts/skills/skill", {
	m = {
		Chance = 50,
		DamageMult = 0.5,
		IsSpinningFlail = false
	},
	function create()
	{
		this.m.ID = "perk.rf_flail_spinner";
		this.m.Name = ::Const.Strings.PerkName.RF_FlailSpinner;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FlailSpinner;
		this.m.Icon = "ui/perks/perk_rf_flail_spinner.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Flail))
		{
			return false;
		}

		return true;
	}

	function spinFlail (_skill, _targetTile)
	{
		local targetEntity = _targetTile.getEntity();
		if (targetEntity == null || this.m.IsSpinningFlail || ::Math.rand(1,100) > this.m.Chance)
		{
			return;
		}

		local user = this.getContainer().getActor();

		if (::Tactical.TurnSequenceBar.isActiveEntity(user))
		{
			if (!user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
			{
				this.getContainer().setBusy(true);
				::Time.scheduleEvent(::TimeUnit.Virtual, 300, function ( perk )
				{
					if (targetEntity.isAlive())
					{
						this.logDebug("[" + user.getName() + "] is Spinning The Flail on target [" + targetEntity.getName() + "] with skill [" + _skill.getName() + "]");
						if (!user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
						{
							::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " is Spinning the Flail");
						}

						perk.m.IsSpinningFlail = true;
						if (user.isPlayerControlled())
						{
							_skill.useForFree(_targetTile);
						}
						// Make it non-lethal for NPC users
						// Hopefully this reduces/elminiates the cases where AI evaluation gets stuck due to killing someone with a delayed attack.
						// Once a proper solution to that issue is found and implemented, this can be reverted.
						else
						{
							// This implementation has a side-effect of preventing the target from receiving injuries.
							local wasAbleToDie = _targetEntity.m.IsAbleToDie;
							_targetEntity.m.IsAbleToDie = false;
							_skill.useForFree(_targetTile);
							_targetEntity.m.IsAbleToDie = wasAbleToDie;
						}
						perk.m.IsSpinningFlail = false;
					}

					this.getContainer().setBusy(false);

				}.bindenv(this), this);
			}
			else
			{
				if (targetEntity.isAlive())
				{
					this.logDebug("[" + user.getName() + "] is Spinning The Flail on target [" + targetEntity.getName() + "] with skill [" + _skill.getName() + "]");
					this.m.IsSpinningFlail = true;

					_skill.useForFree(_targetTile);
					this.m.IsSpinningFlail = false;
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsSpinningFlail)
		{
			_properties.DamageTotalMult *= this.m.DamageMult;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.isEnabled() && _skill.isAttack() && _skill.m.IsWeaponSkill)
		{
			this.spinFlail(_skill, _targetTile);
		}
	}
});
