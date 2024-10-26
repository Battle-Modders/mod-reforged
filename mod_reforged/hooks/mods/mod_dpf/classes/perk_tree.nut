::Reforged.HooksMod.hook(::DynamicPerks.Class.PerkTree, function(q) {
	q.addItemMultipliers = @(__original) function( _multipliers )
	{
		__original(_multipliers);
		local weapon = this.getActor().getMainhandItem();
		if (!::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon))
		{
			local ids = ::Reforged.getWeaponPerkGroups(weapon);
			switch (ids.len())
			{
				case 0:
					break;

				case 1:
					_multipliers[ids[0]] <- -1;
					break;

				default:
					_multipliers[::MSU.Array.rand(ids)] <- -1;
			}
		}
	}
});
