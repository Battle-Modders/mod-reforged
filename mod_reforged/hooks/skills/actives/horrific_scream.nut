::Reforged.HooksMod.hook("scripts/skills/actives/horrific_scream", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Let loose a scream causing your enemies to flee and scatter!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target receives " + ::MSU.Text.colorRed(4) " + mental [morale checks|Concept.Morale]")
		});
		return ret;
	}
});
