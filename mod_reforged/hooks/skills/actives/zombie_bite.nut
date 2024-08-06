::Reforged.HooksMod.hook("scripts/skills/actives/zombie_bite", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Use your rotten teeth to deliver a painful bite.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.getDefaultTooltip();
	}
});
