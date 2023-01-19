::mods_hookExactClass("items/weapons/named/named_polehammer", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/polehammer";
		create();
	}
});
