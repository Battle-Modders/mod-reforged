::mods_hookExactClass("items/weapons/wonky_bow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}
});
