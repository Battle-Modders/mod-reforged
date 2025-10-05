::Reforged.HooksMod.hook("scripts/skills/actives/disarm_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();

		// VanillaFix: We remove the injuries from this skill as it doesnt deal damage anyways
		// This will prevent MSU from falsely displaying a damage type in the description
		// This is in line with how other utility skills like Repel or Hook leave these members on their default value
		this.m.InjuriesOnBody = null;
		this.m.InjuriesOnHead = null;
	}}.create;
});
