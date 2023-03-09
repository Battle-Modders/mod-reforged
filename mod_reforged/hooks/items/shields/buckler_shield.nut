::mods_hookExactClass("items/shields/buckler_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ReachIgnore = 1;
	}
});
