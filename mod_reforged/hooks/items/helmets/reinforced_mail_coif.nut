::Reforged.HooksMod.hook("scripts/items/helmets/reinforced_mail_coif", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 600;
		this.m.StaminaModifier = -4;
	}
});
