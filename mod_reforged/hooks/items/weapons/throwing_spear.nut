::mods_hookExactClass("items/weapons/throwing_spear", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ShieldDamage = 48;
		this.m.Reach = 0;
	}
});
