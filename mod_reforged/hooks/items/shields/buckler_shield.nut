::Reforged.HooksMod.hook("scripts/items/shields/buckler_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ReachIgnore = 1;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
	}
});
