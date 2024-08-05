::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_lindwurm_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 200;
		this.m.ConditionMax = 200;
		// Similar description as vanilla but add mention of "weighs little" because our design of the shield
		// has a much lower stamina modifier than vanilla.
		this.m.Description = "This sturdy shield fashioned from the shimmering scales of a Lindwurm weighs little but makes for protection nigh indestructible.";
		this.m.StaminaModifier = -8; // vanilla -14
		this.m.MeleeDefense = 20; // vanilla 17
		this.m.RangedDefense = 20; // vanilla 25
		this.m.ReachIgnore = 3;
	}
});
