::mods_hookExactClass("items/weapons/longaxe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
		this.m.ShieldDamage = 30;
	}
});
