::Reforged.HooksMod.hook("scripts/items/shields/greenskins/orc_light_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 80;
		this.m.ConditionMax = 80;
	}
});
