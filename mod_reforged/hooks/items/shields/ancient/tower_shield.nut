::mods_hookExactClass("items/shields/ancient/tower_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ReachIgnore = 3;
	}
});
