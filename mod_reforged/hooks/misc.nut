::Reforged.Const <- {};

::Reforged.new <- function( _script, _function = null )
{
	local obj = ::new(_script);
	if (_function != null) _function(obj);
	return obj;
}

// Return a list with ids of all weapon perk groups belonging to the given _weapon
// @param _weapon must be an instance or weakref of an item with the itemtype Weapon
::Reforged.getWeaponPerkGroups <- function( _weapon )
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
