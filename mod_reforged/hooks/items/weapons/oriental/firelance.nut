::mods_hookExactClass("items/weapons/oriental/firelance", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
		// remove Firearm from type so it doesn't interact with systems that check for Firearm weapon type (e.g. weapon mastery)
		// because this is primarily a spear with a secondary one-use firearm attack
		this.setWeaponType(::Const.Items.WeaponType.Spear);
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.MeleeWeapon; // Vanilla doesn't have this causing our systems to not identify this as a melee weapon
	}
});
