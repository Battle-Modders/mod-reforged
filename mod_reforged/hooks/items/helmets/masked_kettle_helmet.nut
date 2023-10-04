::Reforged.HooksMod.hook("scripts/items/helmets/masked_kettle_helmet", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 1000;
		this.m.Condition = 125;
		this.m.ConditionMax = 125;
	}
});
