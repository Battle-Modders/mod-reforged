::Reforged.HooksMod.hook("scripts/items/helmets/nasal_helmet_with_closed_mail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.StaminaModifier = -15; // vanilla -16
	}
});
