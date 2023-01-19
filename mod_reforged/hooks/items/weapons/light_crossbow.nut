::mods_hookExactClass("items/weapons/light_crossbow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}
});
