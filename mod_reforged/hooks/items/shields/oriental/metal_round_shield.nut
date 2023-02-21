::mods_hookExactClass("items/shields/oriental/metal_round_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
	}
});
