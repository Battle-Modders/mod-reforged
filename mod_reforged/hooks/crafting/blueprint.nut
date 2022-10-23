::mods_hookExactClass("crafting/blueprint", function(o) {

    local oldIsQualified = o.isQualified;
    o.isQualified = function()
    {
        if (::Reforged.Mod.ModSettings.getSetting("ShowBlueprintsWhen").getValue() == "Always") return true;    // This does not overwrite special conditions (like Alchemist for Snake Oil)

        if (::Reforged.Mod.ModSettings.getSetting("ShowBlueprintsWhen").getValue() == "One Ingredient Available")
        {
            if (this.isPartlyCraftable()) return true;
        }

        return oldIsQualified();
    }

    o.isPartlyCraftable <- function()    // new helper function
	{
		local items = this.World.Assets.getStash().getItems();

		foreach (c in this.m.PreviewComponents)
		{
			local num = 0;

			foreach (item in items)
			{
				if (item != null && item.getID() == c.Instance.getID())
				{
					num = ++num;
					if (num >= c.Num) return true;
				}
			}
		}

		return false;
	}
}
