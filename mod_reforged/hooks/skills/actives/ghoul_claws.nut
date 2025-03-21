::Reforged.HooksMod.hook("scripts/skills/actives/ghoul_claws", function(q) {
	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.skill.getDefaultTooltip();
	}
});
