::Reforged.HooksMod.hook("scripts/skills/actives/headbutt_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "A forceful attack to inflict blunt trauma.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.skill.getDefaultTooltip();
	}
});
