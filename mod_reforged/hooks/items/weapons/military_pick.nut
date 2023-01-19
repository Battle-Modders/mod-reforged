::mods_hookExactClass("items/weapons/military_pick", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}
});
