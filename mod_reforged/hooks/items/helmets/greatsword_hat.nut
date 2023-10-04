::Reforged.HooksMod.hook("scripts/items/helmets/greatsword_hat", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 1000;
		this.m.Condition = 90;
		this.m.ConditionMax = 90;
	}
});
