// We replace any mentions of "Maximum Fatigue" in the tooltip with "Base Weight"
::mods_hookDescendants("items/item", function(o) {	// hookChildren doesn't catch everything. Nets and Gilders Shield overwrite the tooltip again
	if ("getTooltip" in o)
	{
		local getTooltip = o.getTooltip;
		o.getTooltip = function()
		{
			local ret = getTooltip();
			foreach (entry in ret)
			{
				// Checking for ID is not very useful. Weapons have it under ID 8 while Armor have it under ID 5
				if ("icon" in entry &&
					entry.icon == "ui/icons/fatigue.png" &&
					"text" in entry &&
					entry.text.find("Maximum Fatigue [color=") != null
				)
				{
					entry.text = ::Reforged.Mod.Tooltips.parseString("[Base Weight|Concept.Weight]: " + ::MSU.Text.colorRed(-this.getStaminaModifier()));
					break;
				}
			}
			return ret;
		}
	}
})
