::Reforged.HooksMod.hook("scripts/skills/actives/drums_of_war_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Strike a vigorous rhythm making your allies feel less tired and more eager to fight.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("Every other ally on the battlefield gains the [Drums of War|Skill+drums_of_war_effect] effect")
		});
		return ret;
	}
});
