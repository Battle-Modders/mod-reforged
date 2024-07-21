this.perk_rf_rattle <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Hammer,
		RequiredDamageType = ::Const.Damage.DamageType.Blunt,
		IsForceEnabled = false,
		RequiresWeapon = true
	},
	function create()
	{
		this.m.ID = "perk.rf_rattle";
		this.m.Name = ::Const.Strings.PerkName.RF_Rattle;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Rattle;
		this.m.Icon = "ui/perks/perk_rf_rattle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.getCurrentProperties().IsImmuneToStun || _targetEntity.getCurrentProperties().IsImmuneToDaze || !this.isSkillValid(_skill))
			return;

		_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_rattled_effect"));
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack() || (this.m.RequiredDamageType != null && !_skill.getDamageType().contains(this.m.RequiredDamageType)))
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});

