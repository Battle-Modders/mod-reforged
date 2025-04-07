::Reforged.HooksMod.hook("scripts/items/armor/golems/grand_diviner_robes", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 1600; // vanilla 1200
		this.m.Condition = 135; // vanilla 125
		this.m.ConditionMax = 135; // vanilla 125
	}
});
