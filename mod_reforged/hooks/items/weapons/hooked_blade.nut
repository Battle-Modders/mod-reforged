::mods_hookExactClass("items/weapons/hooked_blade", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}
});
