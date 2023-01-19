::mods_hookExactClass("items/weapons/named/named_throwing_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/throwing_axe";
		create();
	}
});
