::mods_hookExactClass("items/weapons/named/named_dagger", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/rondel_dagger";
		create();
	}
});
