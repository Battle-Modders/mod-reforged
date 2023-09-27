::Reforged.HooksMod.hook("scripts/items/helmets/sallet_helmet", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Open Faced Sallet Helmet";
		this.m.Value = 1500;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
	}
});
