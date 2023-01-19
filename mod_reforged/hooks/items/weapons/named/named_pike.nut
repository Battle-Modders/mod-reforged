::mods_hookExactClass("items/weapons/named/named_pike", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/pike";
		create();
	}
});
