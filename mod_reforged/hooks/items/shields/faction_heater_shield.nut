::mods_hookExactClass("items/shields/faction_heater_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 34;
		this.m.ConditionMax = 34;
		this.m.ReachIgnore = 3;
	}
});
