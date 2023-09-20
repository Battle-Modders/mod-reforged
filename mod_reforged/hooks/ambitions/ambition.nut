::mods_hookBaseClass("ambitions/ambition", function(o) {
	o = o[o.SuperName];

	local getButtonTooltip = o.getButtonTooltip;
	o.getButtonTooltip = function()
	{
		local ret = getButtonTooltip();
		foreach (entry in ret)
		{
			if (entry.text.find("Your Renown will increase, which means higher pay for contracts") != null)
			{
				entry.text = "The company\'s Renown will increase by " + ::MSU.Text.colorGreen("+" + this.getRenownOnSuccess());
				break;
			}
		}
		return ret;
	}
});
