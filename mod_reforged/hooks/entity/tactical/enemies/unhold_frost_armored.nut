::mods_hookExactClass("entity/tactical/enemies/unhold_frost_armored", function(o) {
	o.onInit = function()
	{
	    this.unhold_frost.onInit();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");

		// Reforged
		this.m.Skills.removeByID("perk.fortified_mind");
		this.m.Skills.removeByID("perk.rf_survival_instinct");
	}
});
