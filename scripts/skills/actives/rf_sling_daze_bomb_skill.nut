this.rf_sling_daze_bomb_skill <- ::inherit("scripts/skills/actives/throw_daze_bomb_skill", {
	function create()
	{
		this.throw_daze_bomb_skill.create();
		this.m.Icon = "skills/rf_sling_daze_bomb_skill.png";
		this.m.IconDisabled = "skills/rf_sling_daze_bomb_skill_sw.png";
		this.m.Overlay = "rf_sling_daze_bomb_skill";
		::Reforged.Skills.adjustSlingItemSkill(this);
	}
});
