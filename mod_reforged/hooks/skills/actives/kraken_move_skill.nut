::Reforged.HooksMod.hook("scripts/skills/actives/kraken_move_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Move a tentacle from one place to another.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.skill.getDefaultUtilityTooltip();
	}}.getTooltip;
});
