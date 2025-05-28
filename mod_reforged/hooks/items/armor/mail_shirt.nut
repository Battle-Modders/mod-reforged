::Reforged.HooksMod.hook("scripts/items/armor/mail_shirt", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.StaminaModifier = -13; // vanilla -14
	}}.create;
});
