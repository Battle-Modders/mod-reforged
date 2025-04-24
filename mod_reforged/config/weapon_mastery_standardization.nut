::Reforged.WMS <- {
	WeaponTypeMastery = {
		[::Const.Items.WeaponType.Axe] = "IsSpecializedInAxes",
		[::Const.Items.WeaponType.Bow] = "IsSpecializedInBows",
		[::Const.Items.WeaponType.Cleaver] = "IsSpecializedInCleavers",
		[::Const.Items.WeaponType.Crossbow] = "IsSpecializedInCrossbows",
		[::Const.Items.WeaponType.Dagger] = "IsSpecializedInDaggers",
		[::Const.Items.WeaponType.Flail] = "IsSpecializedInFlails",
		[::Const.Items.WeaponType.Hammer] = "IsSpecializedInHammers",
		[::Const.Items.WeaponType.Mace] = "IsSpecializedInMaces",
		[::Const.Items.WeaponType.Polearm] = "IsSpecializedInPolearms",
		[::Const.Items.WeaponType.Spear] = "IsSpecializedInSpears",
		[::Const.Items.WeaponType.Sword] = "IsSpecializedInSwords",
		[::Const.Items.WeaponType.Throwing] = "IsSpecializedInThrowing"
	},
	WeaponTypeAlias = {
		[::Const.Items.WeaponType.Musical] = ::Const.Items.WeaponType.Mace,
		[::Const.Items.WeaponType.Firearm] = ::Const.Items.WeaponType.Crossbow
	},

	function addMastery( _weaponType, _propertiesKey )
	{
		this.WeaponTypeMastery[_weaponType] <- _propertiesKey;
	}

	function addAlias( _weaponType, _alias )
	{
		this.WeaponTypeAlias[_weaponType] <- _alias;
	}
};
