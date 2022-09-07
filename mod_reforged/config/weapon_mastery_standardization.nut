::Reforged.WMS <- {
	WeaponTypeMastery = {
		Axe = "IsSpecializedInAxes",
		Bow = "IsSpecializedInBows",
		Cleaver = "IsSpecializedInCleavers",
		Crossbow = "IsSpecializedInCrossbows",
		Dagger = "IsSpecializedInDaggers",
		Flail = "IsSpecializedInFlails",
		Hammer = "IsSpecializedInHammers",
		Mace = "IsSpecializedInMaces",
		Polearm = "IsSpecializedInPolearms",
		Spear = "IsSpecializedInSpears",
		Sword = "IsSpecializedInSwords",
		Throwing = "IsSpecializedInThrowing"
	},
	WeaponTypeAlias = {
		Musical = "Mace",
		Firearm = "Crossbow"
	},

	function addMastery( _weaponTypeKey, _propertiesKey )
	{
		this.WeaponTypeMastery[_weaponTypeKey] <- _propertiesKey;
	}

	function addAlias( _weaponTypeKey, _alias )
	{
		this.WeaponTypeAlias[_weaponTypeKey] <- _alias;
	}
};
