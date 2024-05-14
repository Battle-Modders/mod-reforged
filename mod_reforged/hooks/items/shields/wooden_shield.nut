::Reforged.HooksMod.hook("scripts/items/shields/wooden_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
	}
});
