::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_breastplate", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 175; // vanilla 135
		this.m.ConditionMax = 175; // vanilla 135
		this.m.StaminaModifier = -24; // vanilla -22
	}}.create;
});
