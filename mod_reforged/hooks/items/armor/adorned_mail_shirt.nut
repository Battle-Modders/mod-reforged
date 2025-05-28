::Reforged.HooksMod.hook("scripts/items/armor/adorned_mail_shirt", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 800; // vanilla 1050
		this.m.Condition = 130; // vanilla 150
		this.m.ConditionMax = 130; // vanilla 150
		this.m.StaminaModifier = -11; // vanilla -15
	}}.create;
});
