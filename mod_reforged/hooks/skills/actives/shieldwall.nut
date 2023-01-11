::mods_hookExactClass("skills/actives/shieldwall", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
		tooltip.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants immunity to the next stun, but will be lost upon receiving the stun"
			}
		);

		return tooltip;
	}
});
