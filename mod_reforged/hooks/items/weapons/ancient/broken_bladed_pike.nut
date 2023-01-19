::mods_hookExactClass("items/weapons/ancient/broken_bladed_pike", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}
});
