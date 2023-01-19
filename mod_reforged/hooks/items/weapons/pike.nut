::mods_hookExactClass("items/weapons/pike", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 7;
	}
});
