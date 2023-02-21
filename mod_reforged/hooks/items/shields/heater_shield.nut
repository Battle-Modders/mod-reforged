::mods_hookExactClass("items/shields/heater_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 34;
		this.m.ConditionMax = 34;
	}
});
