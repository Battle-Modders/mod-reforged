::mods_hookExactClass("items/shields/kite_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 42;
		this.m.ConditionMax = 42;
	}
});
