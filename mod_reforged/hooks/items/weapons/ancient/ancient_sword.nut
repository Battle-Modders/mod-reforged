::mods_hookExactClass("items/weapons/ancient/ancient_sword", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
	}
});
