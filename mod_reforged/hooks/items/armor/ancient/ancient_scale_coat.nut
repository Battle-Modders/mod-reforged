::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_scale_coat", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 220; // vanilla 190
		this.m.ConditionMax = 220; // vanilla 190
		this.m.StaminaModifier = -28; // vanilla -25
	}
});
