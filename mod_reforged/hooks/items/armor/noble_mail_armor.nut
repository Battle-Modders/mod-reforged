::Reforged.HooksMod.hook("scripts/items/armor/noble_mail_armor", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Value = 2000; // vanilla 2500
		this.m.Condition = 135; // vanilla 160
		this.m.ConditionMax = 135; // vanilla 160
		this.m.StaminaModifier = -12; // vanilla -15
	}}.create;
});
