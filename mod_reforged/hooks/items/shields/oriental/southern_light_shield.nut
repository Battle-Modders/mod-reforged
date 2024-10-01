::Reforged.HooksMod.hook("scripts/items/shields/oriental/southern_light_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.StaminaModifier = -8; // Vanilla is -10.
		this.m.Condition = 40; // vanilla 18
		this.m.ConditionMax = 40; // vanilla 18
	}
});
