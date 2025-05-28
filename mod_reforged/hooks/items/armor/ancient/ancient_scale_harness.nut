::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_scale_harness", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 155; // vanilla 125
		this.m.ConditionMax = 155; // vanilla 125
		this.m.StaminaModifier = -22; // vanilla -20
	}}.create;
});
