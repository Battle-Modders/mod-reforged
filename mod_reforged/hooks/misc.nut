::Reforged.Const <- {};

::MSU.Table.merge(::Reforged, {
	function new( _script, _function = null )
	{
		local obj = ::new(_script);
		if (_function != null) _function(obj);
		return obj;
	}

	// Return a list with ids of all weapon perk groups belonging to the given _weapon
	// @param _weapon must be an instance or weakref of an item with the itemtype Weapon
	function getWeaponPerkGroups( _weapon )
	{
		local ret = [];
		foreach (weaponTypeName, weaponType in ::Const.Items.WeaponType)
		{
			if (!_weapon.isWeaponType(weaponType))
				continue;

			if (weaponTypeName == "Firearm")
				weaponTypeName = "Crossbow";

			local pgID = "pg.rf_" + weaponTypeName.tolower();
			if (::DynamicPerks.PerkGroups.findById(pgID) != null)
			{
				ret.push(pgID);
			}
		}
		return ret;
	}

	// Expands the vanilla ::Const.LevelXP array to allow leveling characters beyond the vanilla max of 33
	// is called from player.addXP and player.onInit so the array is dynamically expanded when needed
	function expandLevelXP( _len )
	{
		while (::Const.LevelXP.len() < _len)
		{
			::Const.LevelXP.push(::Const.LevelXP.top() + 4000 + 1000 * (::Const.LevelXP.len() - 11));
		}
	}
});
