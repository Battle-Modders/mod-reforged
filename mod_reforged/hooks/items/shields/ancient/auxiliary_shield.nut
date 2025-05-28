::Reforged.HooksMod.hook("scripts/items/shields/ancient/auxiliary_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 32;  // vanilla 16
		this.m.ConditionMax = 32; // vanilla 16
	}}.create;
});
