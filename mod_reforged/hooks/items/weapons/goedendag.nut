::mods_hookExactClass("items/weapons/goedendag", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}
});
