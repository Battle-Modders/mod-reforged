::Reforged.HooksMod.hook("scripts/items/armor/adorned_mail_shirt", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 1300;
		this.m.StaminaModifier = -15;
	}
});
