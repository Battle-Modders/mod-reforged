::mods_hookExactClass("items/weapons/morning_star", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}
});
