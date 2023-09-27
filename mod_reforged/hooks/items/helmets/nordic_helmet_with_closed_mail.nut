::Reforged.HooksMod.hook("scripts/items/helmets/nordic_helmet_with_closed_mail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 2700;
		this.m.Condition = 270;
		this.m.ConditionMax = 270;
	}
});
