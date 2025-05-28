::Reforged.HooksMod.hook("scripts/items/helmets/oriental/gladiator_helmet", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 230; // vanilla 225
		this.m.ConditionMax = 230; // vanilla 225
	}}.create;
});
