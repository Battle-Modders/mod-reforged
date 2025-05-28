::Reforged.HooksMod.hook("scripts/items/shields/ancient/tower_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 48; // vanilla 24
		this.m.ConditionMax = 48; // vanilla 24
		this.m.ReachIgnore = 3;
	}}.create;
});
