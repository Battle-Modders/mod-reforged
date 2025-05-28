::Reforged.HooksMod.hook("scripts/items/shields/heater_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 150; // vanilla 32
		this.m.ConditionMax = 150; // vanilla 32
		this.m.ReachIgnore = 3;
	}}.create;
});
