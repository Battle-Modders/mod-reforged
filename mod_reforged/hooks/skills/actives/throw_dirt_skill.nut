::Reforged.HooksMod.hook("scripts/skills/actives/throw_dirt_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character hides a substantial amount of sand in their pockets, ready to be unleashed on an attacker.";
	}

	// Vanilla does not provide an implementation for this function. Since we want to display the cost of the skill we can't build upon the base function from skill.nut
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Applies the [Distracted|Skill+distracted_effect] effect to the target")
		})

		return ret;
	}
});
