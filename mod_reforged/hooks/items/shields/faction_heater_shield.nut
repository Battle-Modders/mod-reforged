::Reforged.HooksMod.hook("scripts/items/shields/faction_heater_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 150;
		this.m.ConditionMax = 150;
		this.m.ReachIgnore = 3;
	}
});
