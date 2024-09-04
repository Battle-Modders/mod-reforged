::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_scale_coat", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
		this.m.StaminaModifier = -28;
	}
});
