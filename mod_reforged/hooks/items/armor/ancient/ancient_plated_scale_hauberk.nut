::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_plated_scale_hauberk", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 250; // vanilla 210
		this.m.ConditionMax = 250; // vanilla 210
		this.m.StaminaModifier = -34; // vanilla -30
	}
});
