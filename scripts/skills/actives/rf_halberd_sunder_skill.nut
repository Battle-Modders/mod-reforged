this.rf_halberd_sunder_skill <- ::inherit("scripts/skills/actives/strike_skill", {
	m = {},
	function create()
	{
		this.strike_skill.create();
		this.m.Name = "Sunder";
		this.m.Icon = "skills/rf_halberd_sunder_skill.png";
		this.m.IconDisabled = "skills/rf_halberd_sunder_skill_sw.png";
		this.m.Overlay = "skills/rf_halberd_sunder_skill";
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 25;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.strike_skill.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
		}
	}
});
