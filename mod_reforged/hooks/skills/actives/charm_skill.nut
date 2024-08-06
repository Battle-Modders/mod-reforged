::Reforged.HooksMod.hook("scripts/skills/actives/charm_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Try to charm a character, forcing him to turn on his allies and obey you instead. The higher a character\'s [Resolve|Concept.Bravery], the higher the chance to resist being charmed.");
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will trigger up to " + ::MSU.Text.colorRed("2") + " [morale checks|Concept.Morale] on the target and if any are successful, the target gains the [Charmed|Skill+charmed_effect] effect")
		});
		return ret;
	}
});
