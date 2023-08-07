this.perk_rf_line_breaker <- ::inherit("scripts/skills/skill", {
	m = {
		KnockBackMeleeSkillBonus = 15
	},
	function create()
	{
		this.m.ID = "perk.rf_line_breaker";
		this.m.Name = ::Const.Strings.PerkName.RF_LineBreaker;
		this.m.Description = ::Const.Strings.PerkDescription.RF_LineBreaker;
		this.m.Icon = "ui/perks/rf_line_breaker.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.knock_back")
		{
			_properties.MeleeSkill += this.m.KnockBackMeleeSkillBonus;
		}
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_line_breaker_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_line_breaker");
	}
});
