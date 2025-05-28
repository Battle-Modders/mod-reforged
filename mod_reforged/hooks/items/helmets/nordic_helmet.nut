::Reforged.HooksMod.hook("scripts/items/helmets/nordic_helmet", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 750; // vanilla 500
		this.m.Condition = 135; // vanilla 125
		this.m.ConditionMax = 135; // vanilla 125
	}}.create;
});
