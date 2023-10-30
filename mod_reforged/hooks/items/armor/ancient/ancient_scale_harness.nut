::mods_hookExactClass("items/armor/ancient/ancient_scale_harness", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 155;
		this.m.ConditionMax = 155;
		this.m.StaminaModifier = -22;
	}
});

