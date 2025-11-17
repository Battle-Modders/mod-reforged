::Reforged.HooksMod.hook("scripts/skills/actives/ghastly_touch", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Attack the very soul of an opponent, damaging them through their armor.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.skill.getDefaultTooltip();
	}}.getTooltip;

	::Reforged.HooksHelper.moveDamageToOnAnySkillUsed(q);
});
