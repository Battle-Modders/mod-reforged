::mods_hookExactClass("items/shields/worn_kite_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.ReachIgnore = 3;
	}
});
