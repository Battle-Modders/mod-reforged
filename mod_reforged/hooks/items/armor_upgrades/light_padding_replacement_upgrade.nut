::mods_hookExactClass("items/armor_upgrades/ancient/light_padding_replacement_upgrade", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
        foreach (entry in ret)
        {
            if (entry.id != 14) continue;
            if (!("text" in entry) || entry.text.find("Maximum Fatigue") == null) continue;
            entry.text = ::MSU.String.replace(entry.text, "penalty to Maximum Fatigue", "Weight");
        }
        return ret;
	}
});
