::Reforged.HooksMod.hook("scripts/items/armor/basic_mail_shirt", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.StaminaModifier = -11; // vanilla -12
	}
});
