this.perk_rf_intimidate <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_intimidate";
		this.m.Name = ::Const.Strings.PerkName.RF_Intimidate;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Intimidate;
		this.m.Icon = "ui/perks/rf_intimidate.png";
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
			local moraleState = _targetEntity.getMoraleState();
			if (moraleState > ::Const.MoraleState.Fleeing && moraleState != ::Const.MoraleState.Ignore)
			{
				_targetEntity.checkMorale(-1, ::Const.MoraleCheckType.Default);
				if (_targetEntity.getMoraleState() < moraleState)
				{
					this.spawnIcon("perk_rf_intimidate", _targetEntity.getTile());
				}
			}
		}
	}
});
