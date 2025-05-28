::Reforged.HooksMod.hook("scripts/items/shields/greenskins/orc_light_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 80; // vanilla 16
		this.m.ConditionMax = 80; // vanilla 16
	}}.create;
});
