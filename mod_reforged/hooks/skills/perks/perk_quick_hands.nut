::Reforged.HooksMod.hook("scripts/skills/perks/perk_quick_hands", function(q) {
	q.getItemActionCost = @(__original) function(_items)
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

		return __original(_items);
	}
});
