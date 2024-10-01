::Reforged.HooksMod.hook("scripts/items/shields/worn_kite_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 80; // vanilla 40
		this.m.ConditionMax = 80; // vanilla 40
		this.m.ReachIgnore = 3;
	}
});
