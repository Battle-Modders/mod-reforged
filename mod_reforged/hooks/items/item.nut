::mods_hookBaseClass("items/item", function(o) {
	o = o[o.SuperName];

	o.m.StaminaModifier <- 0.0; // Vanilla is missing this in item.nut while containing a getStaminaModifier() function
	o.m.InitiativeModifier <- null; // New field added by Reforged to separate stamina and initiative modifiers

	o.getInitiativeModifier <- function()
	{
		return this.m.InitiativeModifier != null ? this.m.InitiativeModifier : this.getStaminaModifier();
	}
});

// The following is just to add InitiativeModifier to the tooltip of items

::mods_hookDescendants("items/item", function(o) {
	local parentName = null;
	local getTooltip = null;
	if ("getTooltip" in o) getTooltip = o.getTooltip;
	else
	{
		local obj = o;
		while ("SuperName" in obj)
		{
			obj = obj[obj.SuperName];
			if ("getTooltip" in obj)
			{
				parentName = obj.ClassName;
				break;
			}
		}
	}

	// This uses a janky hookLeaves implementation from Enduriel
	// Necessary because otherwise you get the hook applied double for things like Crossbows or other descendants which have getTooltip defined in them
	o.getTooltip <- function()
	{
		local hookedHere = false;
		if (!::MSU.isIn("RF_HookOnce", this.m))
		{
			hookedHere = true;
			this.m.RF_HookOnce <- null;
		}

		local ret = getTooltip == null ? this[parentName].getTooltip() : getTooltip();

		if (hookedHere)
		{
			delete this.m.RF_HookOnce;

			if (this.getStaminaModifier() == 0 && this.getInitiativeModifier() == 0)
				return ret;

			foreach (i, entry in ret)
			{
				if (!("icon" in entry) || entry.icon != "ui/icons/fatigue.png" || !("text" in entry) || entry.text.find("Maximum Fatigue [color") == null)
					continue;

				ret.insert(i+1, {
					id = 8,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "Initiative [color=" + this.Const.UI.Color.NegativeValue + "]" + this.getInitiativeModifier() + "[/color]"
				});
				break;
			}
		}

		return ret;
	}
});
