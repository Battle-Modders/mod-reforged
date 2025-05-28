::Reforged.HooksMod.hook("scripts/items/shields/faction_kite_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 200; // vanilla 48
		this.m.ConditionMax = 200; // vanilla 48
		this.m.ReachIgnore = 3;
	}}.create;
});
