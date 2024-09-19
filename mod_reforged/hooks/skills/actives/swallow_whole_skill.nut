::Reforged.HooksMod.hook("scripts/skills/actives/swallow_whole_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Devour an adjacent target whole!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target goes inside your belly, gaining the [Swallowed Whole|Skill+swallowed_whole_effect] effect")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target\'s [morale|Concept.Morale] is set to [Breaking|Concept.Morale]")
		});
		// ret.push({
		// 	id = 12,
		// 	type = "text",
		// 	icon = "ui/icons/special.png",
		// 	text = ::Reforged.Mod.Tooltips.parseString("The target loses the [Shieldwall|Skill+shieldwall_effect], [Spearwall|Skill+spearwall_effect] and [Riposte|Skill+riposte_effect] effects")
		// });
		return ret;
	}
});
