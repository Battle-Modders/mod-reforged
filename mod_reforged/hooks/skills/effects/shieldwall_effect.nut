::Reforged.HooksMod.hook("scripts/skills/effects/shieldwall_effect", function(q) {
	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Immune against [Hook Shield|Skill+rf_hook_shield_skill]")
		});

		return tooltip;
	}
});
