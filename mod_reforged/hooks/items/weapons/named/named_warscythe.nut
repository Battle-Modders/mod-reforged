::mods_hookExactClass("items/weapons/named/named_warscythe", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/ancient/warscythe";
		create();
	}
});
