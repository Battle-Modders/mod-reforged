::Reforged.HooksMod.hook("scripts/items/armor/worn_mail_shirt", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Condition = 105; // vanilla 110
		this.m.ConditionMax = 105; // vanilla 110
	}}.create;
});
