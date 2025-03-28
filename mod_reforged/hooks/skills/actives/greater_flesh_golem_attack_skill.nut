::Reforged.HooksMod.hook("scripts/skills/actives/greater_flesh_golem_attack_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("A heavy blunt melee attack that [stuns|Skill+stunned_effect] the target on hit.");
	}

	// Overwrite, because Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.skill.getDefaultTooltip();
	}
});
