::mods_hookExactClass("items/weapons/dagger", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 1;
	}
});
