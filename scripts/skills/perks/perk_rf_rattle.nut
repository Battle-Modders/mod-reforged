this.perk_rf_rattle <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		RequiresWeapon = true
	},
	function create()
	{
		this.m.ID = "perk.rf_rattle";
		this.m.Name = ::Const.Strings.PerkName.RF_Rattle;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Rattle;
		this.m.Icon = "ui/perks/rf_rattle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.getCurrentProperties().IsImmuneToStun || _targetEntity.getCurrentProperties().IsImmuneToDaze || !this.isSkillValid(_skill))
			return;

		_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_rattled_effect"));
	}

	function isSkillValid( _skill )
	{
		if (!_skill.isAttack())
			return false;

		if (this.m.IsForceEnabled)
			return true;

		if (!_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt))
			return false;

		if (!this.m.RequiresWeapon)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Hammer);
	}
});

