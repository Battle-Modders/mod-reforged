::mods_hookExactClass("items/armor/ancient/ancient_scale_coat", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
		this.m.StaminaModifier = -28;
	}
});
