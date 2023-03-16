::mods_hookExactClass("items/helmets/nordic_helmet", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Value = 750;
		this.m.Condition = 135;
		this.m.ConditionMax = 135;
	}
});
