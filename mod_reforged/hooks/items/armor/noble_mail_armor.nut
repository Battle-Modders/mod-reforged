::Reforged.HooksMod.hook("scripts/items/armor/noble_mail_armor", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 2000;
		this.m.Condition = 135;
		this.m.ConditionMax = 135;
		this.m.StaminaModifier = -12;
	}
});
