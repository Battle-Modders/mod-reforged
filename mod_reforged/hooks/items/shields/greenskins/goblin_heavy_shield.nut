::Reforged.HooksMod.hook("scripts/items/shields/greenskins/goblin_heavy_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
	}
});
