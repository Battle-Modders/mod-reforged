this.perk_rf_dismantle <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		RequiredWeaponType = ::Const.Items.WeaponType.Axe
	},
	function create()
	{
		this.m.ID = "perk.rf_dismantle";
		this.m.Name = ::Const.Strings.PerkName.RF_Dismantle;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Dismantle;
		this.m.Icon = "ui/perks/perk_rf_dismantle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _damageInflictedArmor == 0 || !this.isSkillValid(_skill) || ::Math.rand(1, 100) > 100 * _damageInflictedArmor.tofloat() / _targetEntity.getArmor(_bodyPart))
			return;

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_targetEntity))
			return;

		local effect = _targetEntity.getSkills().getSkillByID("effects.rf_dismantled");
		if (effect == null)
			effect = ::new("scripts/skills/effects/rf_dismantled_effect");

		if (_bodyPart == ::Const.BodyPart.Head)
			effect.m.HeadHitCount++;
		else
			effect.m.BodyHitCount++;

		_targetEntity.getSkills().add(effect);
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
