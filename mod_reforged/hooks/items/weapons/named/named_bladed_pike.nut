::mods_hookExactClass("items/weapons/named/named_bladed_pike", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/ancient/bladed_pike";
		create();
	}
});
