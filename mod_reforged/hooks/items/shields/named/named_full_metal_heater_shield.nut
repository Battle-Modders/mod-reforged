::Reforged.HooksMod.hook("scripts/items/shields/named/named_full_metal_heater_shield", function(q) {
	q.m.BaseItemScript = "scripts/items/shields/heater_shield";

	q.setValuesBeforeRandomize = @(__original) { function setValuesBeforeRandomize( _baseItem )
	{
		__original(_baseItem);
		local siparShield = ::new("scripts/items/shields/oriental/metal_round_shield");
		this.m.Condition = siparShield.m.Condition;
		this.m.ConditionMax = siparShield.m.ConditionMax;
		this.m.StaminaModifier = -16;
	}}.setValuesBeforeRandomize;
});
