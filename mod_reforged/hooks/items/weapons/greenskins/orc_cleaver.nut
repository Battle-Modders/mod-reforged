::mods_hookExactClass("items/weapons/greenskins/orc_cleaver", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}
});
