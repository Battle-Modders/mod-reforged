::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_lindwurm_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 250;
		this.m.ConditionMax = 250;
		this.m.ReachIgnore = 3;
	}
});
