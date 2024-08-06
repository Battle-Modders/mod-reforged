::Reforged.HooksMod.hook("scripts/skills/actives/alp_teleport_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Will teleport to a random tile when any Alp is attacked."; // Vanilla is missing a description for this skill
	}
});
