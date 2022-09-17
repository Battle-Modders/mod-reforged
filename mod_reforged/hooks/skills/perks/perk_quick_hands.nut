::mods_hookExactClass("skills/perks/perk_quick_hands", function(o) {
	local getItemActionCost = o.getItemActionCost;
	o.getItemActionCost = function(_items)
	{
		local twoHandedItemsCount = 0;
		foreach (item in _items)
		{
			if (item == null || item.isItemType(::Const.Items.ItemType.Shield))
			{
				continue;
			}

			if (item.isItemType(::Const.Items.ItemType.TwoHanded) && item.isItemType(::Const.Items.ItemType.MeleeWeapon))
			{
				twoHandedItemsCount++;
			}
		}

		if (twoHandedItemsCount == 2)
		{
			return null;
		}

		return getItemActionCost(_items);
	}
});
