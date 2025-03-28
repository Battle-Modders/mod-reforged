::Reforged.HooksMod.hook("scripts/skills/actives/lesser_flesh_golem_attack_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("A blunt melee attack that [dazes|Skill+dazed_effect] the target on hit if they are not immune to being [stunned.|Skill+stunned_effect]");
	}

	// Overwrite, because Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.skill.getDefaultTooltip();
	}
});
