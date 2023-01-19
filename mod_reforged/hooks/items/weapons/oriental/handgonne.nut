::mods_hookExactClass("items/weapons/oriental/handgonne", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}
});
