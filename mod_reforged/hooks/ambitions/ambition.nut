::mods_hookBaseClass("ambitions/ambition", function(o) {
	o = o[o.SuperName];

	local getButtonTooltip = o.getButtonTooltip;
	o.getButtonTooltip = function()
	{
		local ret = getButtonTooltip();
		if (this.getRenownOnSuccess() != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/ambition_tooltip.png",
				text = ::MSU.Text.colorizeValue(this.getRenownOnSuccess()) + " Renown"
			});
		}
		return ret;
	}
});
