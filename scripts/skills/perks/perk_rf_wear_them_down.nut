this.perk_rf_wear_them_down <- ::inherit("scripts/skills/skill", {
	m = {
		ValidEffects = [
			"effects.stunned",
			"effects.dazed",
			"effects.rf_rattled",
			"effects.net",
			"effects.sleeping",
			"effects.staggered",
			"effects.rooted",
			"effects.web",
			"effects.rf_worn_down"
		]
	},
	function create()
	{
		this.m.ID = "perk.rf_wear_them_down";
		this.m.Name = ::Const.Strings.PerkName.RF_WearThemDown;
		this.m.Description = ::Const.Strings.PerkDescription.RF_WearThemDown;
		this.m.Icon = "ui/perks/rf_wear_them_down.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_skill.isAttack())
		{
			_properties.RerollDefenseChance += 20 * _attacker.getSkills().getSkillsByFunction((@(s) this.m.ValidEffects.find(s.getID()) != null).bindenv(this)).len();
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _targetEntity.isAlive())
		{
			_targetEntity.getSkills().add(::new("scripts/skills/effects/rf_worn_down_effect"));
		}
	}
});
