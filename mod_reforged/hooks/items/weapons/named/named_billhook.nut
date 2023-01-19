::mods_hookExactClass("items/weapons/named/named_billhook", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/billhook";
		create();
	}
});
