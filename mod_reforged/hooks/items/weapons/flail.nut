::mods_hookExactClass("items/weapons/flail", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
	}
});
