::Reforged.HooksMod.hook("scripts/skills/actives/warhound_bite", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Tear into an enemy with your powerful jaw and sharp teeth.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.getDefaultTooltip();
	}}.getTooltip;
});
