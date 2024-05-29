::Reforged.HooksMod.hook("scripts/items/shields/greenskins/orc_heavy_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -25;
	}
});
