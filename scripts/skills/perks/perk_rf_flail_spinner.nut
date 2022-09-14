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
		this.m.Icon = "ui/perks/rf_flail_spinner.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
		if (targetEntity == null || this.m.IsSpinningFlail || ::tMath.rand(1,100) > this.m.Chance)
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

						local isAbleToDie = targetEntity.m.IsAbleToDie;
						if (!user.isPlayerControlled())
						{
							targetEntity.m.IsAbleToDie = false;
						}

						_skill.useForFree(_targetTile);

						if (!user.isPlayerControlled())
						{
							targetEntity.m.IsAbleToDie = isAbleToDie;
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

					local isAbleToDie = targetEntity.m.IsAbleToDie;
					if (!user.isPlayerControlled())
					{
						targetEntity.m.IsAbleToDie = false;
					}

					_skill.useForFree(_targetTile);

					if (!user.isPlayerControlled())
					{
						targetEntity.m.IsAbleToDie = isAbleToDie;
					}

					this.m.IsSpinningFlail = false;
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsSpinningFlail)
		{
			if (!this.getContainer().getActor().isPlayerControlled())
			{
				_properties.DamageTotalMult *= 1.25;
			}

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
