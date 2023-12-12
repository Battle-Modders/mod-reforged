::Reforged.HooksMod.hook("scripts/items/shields/greenskins/goblin_light_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
	}
});
