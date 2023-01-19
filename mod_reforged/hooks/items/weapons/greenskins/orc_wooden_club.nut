::mods_hookExactClass("items/weapons/greenskins/orc_wooden_club", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 3;
	}
});
