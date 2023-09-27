::Reforged.HooksMod.hook("scripts/skills/effects/indomitable_effect", function(q) {
	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		tooltip.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being Culled"
			}
		);

		return tooltip;
	}		
});
