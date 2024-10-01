::Reforged.HooksMod.hook("scripts/items/shields/kite_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 200; // vanilla 48
		this.m.ConditionMax = 200; // vanilla 48
		this.m.ReachIgnore = 3;
	}
});
