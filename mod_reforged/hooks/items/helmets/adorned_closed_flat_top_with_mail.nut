::Reforged.HooksMod.hook("scripts/items/helmets/adorned_closed_flat_top_with_mail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 1200; // vanilla 2000
		this.m.Condition = 230; // vanilla 250
		this.m.ConditionMax = 230; // vanilla 250
		this.m.StaminaModifier = -12; // vanilla -15
	}}.create;
});
