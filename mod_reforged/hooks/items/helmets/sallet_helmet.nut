::Reforged.HooksMod.hook("scripts/items/helmets/sallet_helmet", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Name = "Open Faced Sallet Helmet";
		this.m.Value = 1500; // vanilla 1200
		this.m.Condition = 125; // vanilla 120
		this.m.ConditionMax = 125; // vanilla 120
	}}.create;
});
