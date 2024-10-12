::Reforged.HooksMod.hook("scripts/skills/actives/sleep_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Put your enemies to sleep, making them vulnerable to soul-shattering nightmares!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The target receives a mental [morale check|Concept.Morale] with a greater penalty to [Resolve|Concept.Bravery] the closer they are to you. If successful, the target falls [asleep|Skill+sleeping_effect]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
		});
		return ret;
	}
});
