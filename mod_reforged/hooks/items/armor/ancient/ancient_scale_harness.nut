::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_scale_harness", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 155;
		this.m.ConditionMax = 155;
		this.m.StaminaModifier = -22;
	}
});
