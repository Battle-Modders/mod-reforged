::Reforged.HooksMod.hook("scripts/skills/actives/alp_teleport_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Will teleport to a random tile when any Alp is attacked."; // Vanilla is missing a description for this skill
		// Vanilla is missing icons for this skill
		this.m.Icon = "skills/rf_alp_teleport_skill.png";
		this.m.IconDisabled = "skills/rf_alp_teleport_skill_sw.png";
	}
});
