::Reforged.HooksMod.hook("scripts/items/helmets/golems/grand_diviner_headdress", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 1600; // vanilla 1350
		this.m.Condition = 90; // vanilla 75
		this.m.ConditionMax = 90; // vanilla 75
	}}.create;
});
