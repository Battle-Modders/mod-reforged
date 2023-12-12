::Reforged.HooksMod.hook("scripts/items/shields/heater_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 170;
		this.m.ConditionMax = 170;
		this.m.ReachIgnore = 3;
	}
});
