::Reforged.HooksMod.hook("scripts/items/shields/oriental/metal_round_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
	}
});
