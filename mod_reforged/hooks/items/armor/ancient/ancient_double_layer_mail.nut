::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_double_layer_mail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 135; // vanilla 120
		this.m.ConditionMax = 135; // vanilla 120
	}}.create;
});
