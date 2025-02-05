::Reforged.HooksMod.hook("scripts/skills/actives/horror_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Trigger your targets\' deepest fears, causing them to freeze with fright!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target receives a negative mental [morale check|Concept.Morale] with a " + ::MSU.Text.colorNegative(-15) + " penalty to [Resolve|Concept.Bravery]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target receives an additional mental [morale check|Concept.Morale] with a " + ::MSU.Text.colorNegative(-5) + " penalty to [Resolve.|Concept.Bravery] If this [morale check|Concept.MoraleCheck] succeeds, the target gains the [Horrified|Skill+horrified_effect] effect")
		});
		return ret;
	}
});
