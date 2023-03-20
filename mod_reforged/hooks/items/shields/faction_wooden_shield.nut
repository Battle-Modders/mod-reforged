::mods_hookExactClass("items/shields/faction_wooden_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
	}
});
