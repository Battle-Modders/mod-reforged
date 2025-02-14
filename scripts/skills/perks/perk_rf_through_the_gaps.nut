this.perk_rf_through_the_gaps <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Piercing,
		RequiredWeaponType = ::Const.Items.WeaponType.Spear,
		DamageDirectModifierMin = 0.10,
		DamageDirectModifierMax = 0.25
	},
	function create()
	{
		this.m.ID = "perk.rf_through_the_gaps";
		this.m.Name = ::Const.Strings.PerkName.RF_ThroughTheGaps;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ThroughTheGaps;
		this.m.Icon = "ui/perks/perk_rf_through_the_gaps.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.isSkillValid(_skill))
		{
			_properties.DamageDirectAdd += _targetEntity == null ? this.m.DamageDirectModifierMax : ::MSU.Math.randf(this.m.DamageDirectModifierMin, this.m.DamageDirectModifierMax);
		}
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
