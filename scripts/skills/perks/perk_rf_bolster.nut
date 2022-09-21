this.perk_rf_bolster <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_bolster";
		this.m.Name = ::Const.Strings.PerkName.RF_Bolster;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Bolster;
		this.m.Icon = "ui/perks/rf_bolster.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || weapon.getReach() < 6)
		{
			return false;
		}

		return true;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity != null && this.getContainer().getActor().isPlacedOnMap() && _skill.isAttack() && !_skill.isRanged() && (this.m.IsForceEnabled || _skill.m.IsWeaponSkill) && this.isEnabled())
		{
			local allies = ::Tactical.Entities.getFactionActors(this.getContainer().getActor(), this.getContainer().getActor().getTile(), 1, true);
			foreach (ally in allies)
			{
				local moraleState = ally.getMoraleState();
				if (moraleState < ::Const.MoraleState.Confident)
				{
					ally.checkMorale(1);
					if (ally.getMoraleState() > moraleState)
					{
						this.spawnIcon("perk_rf_bolster", ally.getTile());
					}
				}
			}
		}
	}
});
