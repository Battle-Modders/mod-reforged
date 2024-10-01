::Reforged.HooksMod.hook("scripts/items/helmets/conic_helmet_with_closed_mail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 2800; // vanilla 2600
		this.m.Condition = 275; // vanilla 265
		this.m.ConditionMax = 275; // vanilla 265
	}
});
