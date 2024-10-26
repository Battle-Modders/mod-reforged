::Reforged.Const <- {};

::Reforged.Const.WeaponTypeToPerkGroupsMap <- {};

// This needs to be adjusted if mods introduce or change weapon types and perk groups for those types
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Axe] <- "pg.rf_axe";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Bow] <- "pg.rf_bow";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Cleaver] <- "pg.rf_cleaver";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Dagger] <- "pg.rf_dagger";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Flail] <- "pg.rf_flail";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Hammer] <- "pg.rf_hammer";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Mace] <- "pg.rf_mace";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Polearm] <- "pg.rf_polearm";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Spear] <- "pg.rf_spear";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Sword] <- "pg.rf_sword";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Throwing] <- "pg.rf_throwing";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Crossbow] <- "pg.rf_crossbow";
::Reforged.Const.WeaponTypeToPerkGroupsMap[::Const.Items.WeaponType.Firearm] <- "pg.rf_crossbow";

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
	local ids = [];
	foreach (weaponType, perkGroup in ::Reforged.Const.WeaponTypeToPerkGroupsMap)
	{
		if (_weapon.isWeaponType(weaponType))
		{
			ids.push(perkGroup);
		}
	}

	return ids;
}
