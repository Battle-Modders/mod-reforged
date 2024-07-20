this.perk_rf_dent_armor <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredDamageType = ::Const.Damage.DamageType.Blunt,
		RequiredArmorMax = 210
		Chance = 66
	},
	function create()
	{
		this.m.ID = "perk.rf_dent_armor";
		this.m.Name = ::Const.Strings.PerkName.RF_DentArmor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DentArmor;
		this.m.Icon = "ui/perks/rf_dent_armor.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || !this.isSkillValid(_skill))
			return;

		local targetArmorItem = _bodyPart == ::Const.BodyPart.Head ? _targetEntity.getHeadItem() : _targetEntity.getBodyItem();
		if (targetArmorItem == null || targetArmorItem.getArmorMax() <= this.m.RequiredArmorMax || ::Math.rand(1, 100) > this.m.Chance)
			return;

		_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_dented_armor_effect"));
	}

	function isSkillValid( _skill )
	{
		return _skill.isAttack() && (this.m.RequiredDamageType == null || _skill.getDamageType().contains(this.m.RequiredDamageType));
	}
});
