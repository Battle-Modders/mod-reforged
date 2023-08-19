::mods_hookExactClass("items/helmets/physician_mask", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 200;
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
	}
});
