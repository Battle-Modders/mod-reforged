::mods_hookExactClass("items/weapons/ancient/ancient_spear", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}
});
