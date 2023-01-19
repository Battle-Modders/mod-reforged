::mods_hookExactClass("items/weapons/arming_sword", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
	}
});
