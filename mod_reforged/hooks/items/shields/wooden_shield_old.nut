::Reforged.HooksMod.hook("scripts/items/shields/wooden_shield_old", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
	}
});
