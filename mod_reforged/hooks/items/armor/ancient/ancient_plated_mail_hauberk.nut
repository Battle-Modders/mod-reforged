::Reforged.HooksMod.hook("scripts/items/armor/ancient/ancient_plated_mail_hauberk", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 200;
		this.m.ConditionMax = 200;
		this.m.StaminaModifier = -26;
	}
});
