this.rf_sling_acid_flask_skill <- ::inherit("scripts/skills/actives/throw_acid_flask", {
	function create()
	{
		this.throw_acid_flask.create();
		this.m.Icon = "skills/rf_sling_acid_flask_skill.png";
		this.m.IconDisabled = "skills/rf_sling_acid_flask_skill_sw.png";
		this.m.Overlay = "rf_sling_acid_flask_skill";
		::Reforged.Skills.adjustSlingItemSkill(this);
	}
});
