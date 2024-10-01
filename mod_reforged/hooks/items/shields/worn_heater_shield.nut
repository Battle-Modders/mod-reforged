::Reforged.HooksMod.hook("scripts/items/shields/worn_heater_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 48; // vanilla 24
		this.m.ConditionMax = 48; // vanilla 24
		this.m.ReachIgnore = 3;
	}
});
