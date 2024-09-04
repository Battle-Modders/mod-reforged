::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_breastplate", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 175;
		this.m.ConditionMax = 175;
		this.m.StaminaModifier = -24;
	}
});
