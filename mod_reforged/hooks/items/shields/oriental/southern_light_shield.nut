::Reforged.HooksMod.hook("scripts/items/shields/oriental/southern_light_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.StaminaModifier = -9; // Vanilla is -10.
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
	}
});
