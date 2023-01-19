::mods_hookExactClass("items/weapons/named/named_flail", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/flail";
		create();
	}
});
