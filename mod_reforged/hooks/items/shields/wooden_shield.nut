::Reforged.HooksMod.hook("scripts/items/shields/wooden_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 100; // vanilla 24
		this.m.ConditionMax = 100; // vanilla 24
	}}.create;
});
