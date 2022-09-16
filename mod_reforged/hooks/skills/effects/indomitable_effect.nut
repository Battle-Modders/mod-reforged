::mods_hookExactClass("skills/effects/indomitable_effect", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
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
