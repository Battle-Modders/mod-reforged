::mods_hookExactClass("items/weapons/greenskins/orc_javelin", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}
});
