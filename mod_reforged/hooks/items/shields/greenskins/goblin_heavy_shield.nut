::Reforged.HooksMod.hook("scripts/items/shields/greenskins/goblin_heavy_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 40; // vanilla 40
		this.m.ConditionMax = 40; // vanilla 40
	}}.create;
});
