::mods_hookExactClass("items/helmets/masked_kettle_helmet", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 1000;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
	}
});
