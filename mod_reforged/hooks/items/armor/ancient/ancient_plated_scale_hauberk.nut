::mods_hookExactClass("items/armor/ancient/ancient_plated_scale_hauberk", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 250;
		this.m.ConditionMax = 250;
		this.m.StaminaModifier = -34;
	}
});
