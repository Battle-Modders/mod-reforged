::Reforged.HooksMod.hook("scripts/skills/actives/golem_grapple_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("A melee attack that deals no damage but [disarms|Skill+disarmed_effect] the target on a hit.");
	}

	// Overwrite, because Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.skill.getDefaultTooltip();
	}
});
