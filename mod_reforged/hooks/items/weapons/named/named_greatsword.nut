::mods_hookExactClass("items/weapons/named/named_greatsword", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greatsword";
		create();
	}
});
