::mods_hookExactClass("items/weapons/masterwork_bow", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}
});
