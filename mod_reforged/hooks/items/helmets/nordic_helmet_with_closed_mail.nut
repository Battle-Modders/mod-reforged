::Reforged.HooksMod.hook("scripts/items/helmets/nordic_helmet_with_closed_mail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 2700; // vanilla 2600
		this.m.Condition = 270; // vanilla 265
		this.m.ConditionMax = 270; // vanilla 265
	}}.create;
});
