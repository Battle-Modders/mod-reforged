::Reforged.HooksMod.hook("scripts/items/shields/oriental/metal_round_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 280;
		this.m.ConditionMax = 280;
	}
});
