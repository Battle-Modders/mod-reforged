::mods_hookExactClass("items/weapons/oriental/light_southern_mace", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}
});
