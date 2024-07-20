this.rf_sling_holy_water_skill <- ::inherit("scripts/skills/actives/throw_holy_water", {
	function create()
	{
		this.throw_holy_water.create();
		this.m.Icon = "skills/rf_sling_holy_water_skill.png";
		this.m.IconDisabled = "skills/rf_sling_holy_water_skill_sw.png";
		this.m.Overlay = "rf_sling_holy_water_skill";
		::Reforged.Skills.adjustSlingItemSkill(this);
	}
});
