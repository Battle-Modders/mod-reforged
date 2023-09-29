::Reforged.HooksMod.hook("scripts/items/helmets/adorned_closed_flat_top_with_mail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 260;
		this.m.ConditionMax = 260;
	}
});
