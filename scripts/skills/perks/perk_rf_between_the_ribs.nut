this.perk_rf_between_the_ribs <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		DamageBonusPerSurroundCount = 0.05
	},
	function create()
	{
		this.m.ID = "perk.rf_between_the_ribs";
		this.m.Name = ::Const.Strings.PerkName.RF_BetweenTheRibs;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BetweenTheRibs;
		this.m.Icon = "ui/perks/rf_between_the_ribs.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
		{
			return false;
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _targetEntity != null && this.isEnabled() && !_targetEntity.getCurrentProperties().IsImmuneToSurrounding && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			_properties.DamageTotalMult *= 1.0 + (this.m.DamageBonusPerSurroundCount * _targetEntity.getSurroundedCount());
		}

	}
});
