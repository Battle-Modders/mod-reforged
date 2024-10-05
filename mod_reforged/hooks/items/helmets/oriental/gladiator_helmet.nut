::Reforged.HooksMod.hook("scripts/items/helmets/oriental/gladiator_helmet", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
	}
});
