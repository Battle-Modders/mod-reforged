::mods_hookExactClass("items/shields/special/craftable_schrat_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 42;
		this.m.ConditionMax = 42;
	}
});
