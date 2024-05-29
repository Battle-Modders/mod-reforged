::Reforged.HooksMod.hook("scripts/items/shields/oriental/metal_round_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 15;
		this.m.StaminaModifier = -25;
		this.m.ReachIgnore = 3;
	}
});
