::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_schrat_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 170;
		this.m.ConditionMax = 170;
	}
});
