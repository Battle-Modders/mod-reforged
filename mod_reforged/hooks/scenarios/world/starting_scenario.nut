::Reforged.HooksMod.hookTree("scripts/scenarios/world/starting_scenario", function(q) {
	q.onSpawnAssets = @(__original) function()
	{
		__original();

		// The following code will guarantee that every starting brother has at least one weapon group corresponding to their currently equipped weapon
		// However it might overwrite another weapon group that was given to that background specifically or which was highly likely to be on it
		foreach (brother in ::World.getPlayerRoster().getAll())
		{
			local weapon = brother.getMainhandItem();
			if (::MSU.isNull(weapon) || !weapon.isItemType(::Const.Items.ItemType.Weapon))
			{
				continue;
			}

			local perkGroupIds = ::Reforged.getWeaponPerkGroups(weapon);
			if (perkGroupIds.len() == 0) // The weapon had no weapon groups associated with it (e.g. Lute)
			{
				continue;
			}

			local newPerkGroupId = ::MSU.Array.rand(perkGroupIds);	// We choose one random weapon group belonging to our currently equipped weapon
			local perkTree = brother.getPerkTree();
			if (perkTree.hasPerkGroup(newPerkGroupId))	// If we already have that weapon group, we are done and do nothing
			{
				continue;
			}

			local existingWeaponGroups = [];
			local category = ::DynamicPerks.PerkGroupCategories.findById("pgc.rf_weapon");
			foreach (groupID in category.getGroups())
			{
				if (perkTree.hasPerkGroup(groupID)) existingWeaponGroups.push(groupID);
			}

			if (existingWeaponGroups.len() != 0)	// If an origin character does not have any weapon group to begin, we will keep it that way. It was probably for good reason
			{
				perkTree.removePerkGroup(::MSU.Array.rand(existingWeaponGroups));
				perkTree.addPerkGroup(newPerkGroupId);
			}
		}
	}
});
