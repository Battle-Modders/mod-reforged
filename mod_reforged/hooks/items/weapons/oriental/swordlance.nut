::mods_hookExactClass("items/weapons/oriental/swordlance", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 6;
	}
});
