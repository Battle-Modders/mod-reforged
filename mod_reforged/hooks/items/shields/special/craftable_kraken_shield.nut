::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_kraken_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
	}
});
