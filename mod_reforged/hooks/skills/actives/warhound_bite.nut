::Reforged.HooksMod.hook("scripts/skills/actives/warhound_bite", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Lash at them with your large muzzle, biting and tearing apart flesh.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.getDefaultTooltip();
	}
});
