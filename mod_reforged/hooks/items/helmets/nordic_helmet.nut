::Reforged.HooksMod.hook("scripts/items/helmets/nordic_helmet", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 750;
		this.m.Condition = 135;
		this.m.ConditionMax = 135;
	}
});
