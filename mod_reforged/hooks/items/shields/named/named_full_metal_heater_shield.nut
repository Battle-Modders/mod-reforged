::Reforged.HooksMod.hook("scripts/items/shields/named/named_full_metal_heater_shield", function(q) {
	q.m.BaseItemScript = "scripts/items/shields/heater_shield";

	q.getValuesForRandomize = @(__original) function()
	{
		local ret = __original()
		local siparShield = ::new("scripts/items/shields/oriental/metal_round_shield");
		ret.Condition = siparShield.m.Condition;
		ret.ConditionMax = siparShield.m.ConditionMax;
		ret.StaminaModifier = -16;

		return ret;
	}
});
