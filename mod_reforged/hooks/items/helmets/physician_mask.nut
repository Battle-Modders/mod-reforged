::Reforged.HooksMod.hook("scripts/items/helmets/physician_mask", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 200;
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
	}
});
