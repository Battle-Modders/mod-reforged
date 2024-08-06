::Reforged.HooksMod.hook("scripts/skills/actives/uproot_small_zoc_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Raise thorny roots from the ground to attack someone trying to move [away|Concept.ZoneOfControl] from you!");
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
