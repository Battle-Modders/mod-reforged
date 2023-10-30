::mods_hookExactClass("items/armor/ancient/ancient_plate_harness", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 235;
		this.m.ConditionMax = 235;
		this.m.StaminaModifier = -32;
	}
});

