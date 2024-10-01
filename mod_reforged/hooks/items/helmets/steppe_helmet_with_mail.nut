::Reforged.HooksMod.hook("scripts/items/helmets/steppe_helmet_with_mail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 1500; // vanilla 1250
		this.m.StaminaModifier = -11; // vanilla -12
	}
});
