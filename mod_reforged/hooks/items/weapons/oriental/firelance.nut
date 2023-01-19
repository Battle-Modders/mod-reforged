::mods_hookExactClass("items/weapons/oriental/firelance", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
	}
});
