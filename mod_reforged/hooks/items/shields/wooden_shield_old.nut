::Reforged.HooksMod.hook("scripts/items/shields/wooden_shield_old", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 40; // vanilla 16
		this.m.ConditionMax = 40; // vanilla 16
	}}.create;
});
