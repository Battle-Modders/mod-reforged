::Reforged.HooksMod.hook("scripts/skills/actives/serpent_bite_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Use your fangs to bite and pierce your target\'s flesh.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.skill.getDefaultTooltip();
	}}.getTooltip;
});
