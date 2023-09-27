::Reforged.HooksMod.hook("scripts/items/armor/worn_mail_shirt", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 105;
		this.m.ConditionMax = 105;
	}
});
