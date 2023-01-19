::mods_hookExactClass("items/weapons/greenskins/goblin_spiked_balls", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 0;
	}
});
