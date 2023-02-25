::mods_hookBaseClass("items/item", function (o) {
	o = o[o.SuperName];

    // Ideally we would call this 'Weight' but we want to maintain backwards compatibility and all mods/vanilla use this variable name
	o.m.StaminaModifier <- 0.0;     // In vanilla this variable is created by hand for every itemType that is equippable

	o.getWeight <- function()
	{
		return ::Math.max(0, (this.m.StaminaModifier * -1));	// We define here that an Item can never have a negative weight
	}
});

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
				// Checking for ID is not very useful. Weapons have it under ID 8 while Armor has it under ID 5
				if (!("icon" in entry) || entry.icon != "ui/icons/fatigue.png") continue;
				if (!("text" in entry) || entry.text.find("Maximum Fatigue [color=") == null) continue;

				entry.text = ::Reforged.Mod.Tooltips.parseString("[Base Weight|Concept.Weight]: " + ::MSU.Text.colorRed(this.getWeight()));
				break;
			}
			return ret;
		}
	}
})
