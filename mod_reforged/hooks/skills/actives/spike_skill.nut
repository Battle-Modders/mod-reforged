::Reforged.HooksMod.hook("scripts/skills/actives/spike_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("A powerful piercing melee attack that strikes up to three enemies in a line.");
	}

	// Overwrite, because Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.skill.getDefaultTooltip();
	}
});
