::Reforged.HooksMod.hook("scripts/skills/actives/flurry_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("An unpredictable melee blunt attack that strikes six times, distributing the hits evenly among all adjacent enemies.");
	}

	// Overwrite, because Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.skill.getDefaultTooltip();
	}
});
