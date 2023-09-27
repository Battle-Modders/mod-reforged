::Reforged.HooksMod.hook("scripts/items/helmets/conic_helmet_with_faceguard", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 290;
		this.m.ConditionMax = 290;
	}
});
