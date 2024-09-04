::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_plate_harness", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 235;
		this.m.ConditionMax = 235;
		this.m.StaminaModifier = -32;
	}
});
