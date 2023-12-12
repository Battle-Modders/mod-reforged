::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_lindwurm_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 280;
		this.m.ConditionMax = 280;
		this.m.ReachIgnore = 3;
	}
});
