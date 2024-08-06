::Reforged.HooksMod.hook("scripts/skills/actives/explode_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Explode into a shrapnel of bone damaging everyone next to you.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Deals a small amount of damage to everyone on adjacent tiles")
		});
		return ret;
	}
});
