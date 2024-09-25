::Reforged.HooksMod.hook("scripts/items/armor/sellsword_armor", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 4750;
		this.m.StaminaModifier = -30;
	}
});
