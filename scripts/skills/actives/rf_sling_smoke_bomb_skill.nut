this.rf_sling_smoke_bomb_skill <- ::inherit("scripts/skills/actives/throw_smoke_bomb_skill", {
	function create()
	{
		this.throw_smoke_bomb_skill.create();
		this.m.Icon = "skills/rf_sling_smoke_bomb_skill.png";
		this.m.IconDisabled = "skills/rf_sling_smoke_bomb_skill_sw.png";
		this.m.Overlay = "rf_sling_smoke_bomb_skill";
		::Reforged.Skills.adjustSlingItemSkill(this);
	}
});
