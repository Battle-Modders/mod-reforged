this.perk_rf_from_all_sides <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Flail
	},
	function create()
	{
		this.m.ID = "perk.rf_from_all_sides";
		this.m.Name = ::Const.Strings.PerkName.RF_FromAllSides;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FromAllSides;
		this.m.Icon = "ui/perks/perk_rf_from_all_sides.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (!this.isSkillValid(_skill))
			return;

		if (!this.getContainer().RF_validateSkillCounter(_targetEntity))
			return;

		local effect = _targetEntity.getSkills().getSkillByID("effects.rf_from_all_sides");
		if (effect == null)
		{
			effect = ::new("scripts/skills/effects/rf_from_all_sides_effect");
		}

		effect.proc(_hitInfo);
		_targetEntity.getSkills().add(effect);
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
