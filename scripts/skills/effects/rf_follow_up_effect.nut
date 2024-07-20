this.rf_follow_up_effect <- ::inherit("scripts/skills/skill", {
	m = {
		DamageMalus = 30,
		DamageMalusIncreasePerProc = 10,
		ProcCount = 0,
		IsProccing = false
	},
	function create()
	{
		this.m.ID = "effects.rf_follow_up";
		this.m.Name = "Follow Up";
		this.m.Description = "Every time an enemy gets hit in this character\'s attack range by an ally, this character perform a free non-lethal attack against that enemy with reduced damage.";
		this.m.Icon = "ui/perks/rf_follow_up.png";
		this.m.IconMini = "rf_follow_up_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]" + this.getCurrentMalus() + "%[/color] reduced damage inflicted"
		});

		if (!this.isEnabled())
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Cannot follow up when engaged in melee")
			});
		}

		return tooltip;
	}

	function isEnabled()
	{
		local actor = this.getContainer().getActor();

		if (!actor.getCurrentProperties().IsAbleToUseWeaponSkills || !actor.hasZoneOfControl() || actor.isEngagedInMelee())
		{
			return false;
		}

		return true;
	}

	function getCurrentMalus()
	{
		return ::Math.min(90, this.m.DamageMalus + (this.m.ProcCount * this.m.DamageMalusIncreasePerProc));
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap() || this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			this.removeSelf();
			return;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsProccing)
		{
			_properties.DamageTotalMult *= 1.0 - this.getCurrentMalus() * 0.01;
		}
	}

	function proc( _targetEntity )
	{
		if (!this.isEnabled())
		{
			return;
		}

		local user = this.getContainer().getActor();
		local targetTile = _targetEntity.getTile();

		if (!user.getTile().hasLineOfSightTo(targetTile, user.getCurrentProperties().getVision()))
			return;

		local attack = this.getContainer().getAttackOfOpportunity();
		if (attack != null && attack.verifyTargetAndRange(targetTile, this.getContainer().getActor().getTile()))
		{
			if (!user.isHiddenToPlayer() || targetTile.IsVisibleForPlayer)
			{
				this.getContainer().setBusy(true);
				::Time.scheduleEvent(::TimeUnit.Virtual, 300, function( _effect ) {
					if (_targetEntity.isAlive() && !_targetEntity.isDying())
					{
						::logDebug("[" + user.getName() + "] is Following Up with skill [" + attack.getName() + "] on target [" + _targetEntity.getName() + "]");

						if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
						{
							::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " is Following Up");
						}

						_effect.m.IsProccing = true;
						attack.useForFree(targetTile);
						_effect.m.ProcCount++;
						_effect.m.IsProccing = false;
					}

					this.getContainer().setBusy(false);
				}.bindenv(this), this);
			}
			else
			{
				if (_targetEntity.isAlive() && !_targetEntity.isDying())
				{
					::logDebug("[" + user.getName() + "] is Following Up with skill [" + attack.getName() + "] on target [" + _targetEntity.getName() + "]");

					this.m.IsProccing = true;
					attack.useForFree(targetTile);
					this.m.ProcCount++;
					this.m.IsProccing = false;
				}
			}
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});
