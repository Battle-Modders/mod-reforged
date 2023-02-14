::mods_hookExactClass("items/weapons/longaxe", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ShieldDamage = 50;
		this.m.Reach = 6;
	}
});
