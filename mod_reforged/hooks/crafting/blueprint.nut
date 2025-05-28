::Reforged.HooksMod.hook("scripts/crafting/blueprint", function(q) {
// New Functions
	// Return true, if the player has at least one ingredient needed for this blueprint
	q.isPartlyCraftable <- { function isPartlyCraftable()
	{
		foreach (item in ::World.Assets.getStash().getItems())
		{
			if (item == null) continue;

			foreach (c in this.m.PreviewComponents)
			{
				if (item.getID() == c.Instance.getID())
				{
					return true;
				}
			}
		}

		return false;
	}}.isPartlyCraftable;
});
