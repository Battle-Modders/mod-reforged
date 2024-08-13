::mods_hookExactClass("items/armor/ancient/ancient_breastplate", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Condition = 175;
		this.m.ConditionMax = 175;
		this.m.StaminaModifier = -24;
	}
});
