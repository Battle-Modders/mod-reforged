this.perk_rf_between_the_ribs <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Dagger,
		RequiredDamageType = ::Const.Damage.DamageType.Piercing,
		DamageBonusPerSurroundCount = 0.1
	},
	function create()
	{
		this.m.ID = "perk.rf_between_the_ribs";
		this.m.Name = ::Const.Strings.PerkName.RF_BetweenTheRibs;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BetweenTheRibs;
		this.m.Icon = "ui/perks/perk_rf_between_the_ribs.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && !_targetEntity.getCurrentProperties().IsImmuneToSurrounding && this.isSkillValid(_skill))
		{
			local mult = 1.0 + (this.m.DamageBonusPerSurroundCount * _targetEntity.getSurroundedCount());
			_properties.DamageRegularMult *= mult;
			_properties.DamageDirectMult *= mult;
		}

	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || _skill.isRanged() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
