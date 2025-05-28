::Reforged.HooksMod.hook("scripts/items/helmets/greatsword_hat", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 1000; // vanilla 200
		this.m.Condition = 90; // vanilla 70
		this.m.ConditionMax = 90; // vanilla 70
	}}.create;
});
