::Reforged.HooksMod.hook("scripts/skills/actives/uproot_small_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Raise thorny roots from the ground to smash and impale multiple targets.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The target becomes [staggered|Skill+staggered_effect] on a hit")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Does not damage or affect other Schrats")
			}
		]);
		return ret;
	}
});
