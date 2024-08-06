::Reforged.HooksMod.hook("scripts/skills/actives/crack_the_whip_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Crack your whip to keep your wild pets obedient.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will prevent your animals from going wild for their next [turn|Concept.Turn]")
		});
		return ret;
	}
});
