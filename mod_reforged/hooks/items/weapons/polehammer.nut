::mods_hookExactClass("items/weapons/polehammer", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}
});
