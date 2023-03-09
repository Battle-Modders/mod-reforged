::mods_hookExactClass("items/shields/kite_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 46;
		this.m.ConditionMax = 46;
		this.m.ReachIgnore = 3;
	}
});
