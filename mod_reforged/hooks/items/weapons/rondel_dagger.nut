::mods_hookExactClass("items/weapons/rondel_dagger", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 1;
	}
});
