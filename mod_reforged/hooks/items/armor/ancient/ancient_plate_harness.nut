::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_plate_harness", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 235; // vanilla 200
		this.m.ConditionMax = 235; // vanilla 200
		this.m.StaminaModifier = -32; // vanilla -28
	}
});
