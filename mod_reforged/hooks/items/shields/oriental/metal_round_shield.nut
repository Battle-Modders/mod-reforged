::Reforged.HooksMod.hook("scripts/items/shields/oriental/metal_round_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 300; // vanilla 60
		this.m.ConditionMax = 300; // vanilla 60
		this.m.MeleeDefense = 25; // vanilla 18
		this.m.RangedDefense = 10; // vanilla 18
		this.m.StaminaModifier = -22; // vanilla -18
		this.m.ReachIgnore = 3;
	}
});
