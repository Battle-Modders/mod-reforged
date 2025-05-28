::Reforged.HooksMod.hook("scripts/items/shields/ancient/coffin_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 40; // vanilla 20
		this.m.ConditionMax = 40; // vanilla 20
		this.m.ReachIgnore = 3;
	}}.create;
});
