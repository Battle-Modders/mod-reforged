::Reforged.HooksMod.hook("scripts/skills/actives/wolf_bite", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Lash at them with your muzzle, biting and tearing apart flesh.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.getDefaultTooltip();
	}}.getTooltip;

	// VanillaFix: Prevent passive damage modification from this skill for goblin wolfriders
	::Reforged.HooksHelper.moveDamageToOnAnySkillUsed(q);
});
