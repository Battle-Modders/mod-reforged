::mods_hookExactClass("items/shields/named/named_full_metal_heater_shield", function(o) {
	o.m.BaseItemScript <- "scripts/items/shields/heater_shield";

	local getValuesForRandomize = "getValuesForRandomize" in o ? o.getValuesForRandomize : null;
	o.getValuesForRandomize <- function()
	{
		local ret = getValuesForRandomize != null ? getValuesForRandomize() : this.named_shield.getValuesForRandomize();
		local siparShield = ::new("scripts/items/shields/oriental/metal_round_shield");
		ret.Condition = siparShield.m.Condition;
		ret.ConditionMax = siparShield.m.ConditionMax;
		ret.StaminaModifier = -16;

		return ret;
	}
});
