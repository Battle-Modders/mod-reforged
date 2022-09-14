this.perk_rf_through_the_gaps <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Bonus = 0.15
	},
	function create()
	{
		this.m.ID = "perk.rf_through_the_gaps";
		this.m.Name = ::Const.Strings.PerkName.RF_ThroughTheGaps;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ThroughTheGaps;
		this.m.Icon = "ui/perks/rf_through_the_gaps.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && (this.m.IsForceEnabled || (!_skill.isRanged() && _skill.getDamageType().contains(::Const.Damage.DamageType.Piercing))))
		{
			_properties.DamageDirectAdd += this.m.Bonus;
		}
	}
});
