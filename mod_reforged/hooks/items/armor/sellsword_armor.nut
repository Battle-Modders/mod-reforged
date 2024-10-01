::Reforged.HooksMod.hook("scripts/items/armor/sellsword_armor", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 4750;  // vanilla 4500
		this.m.StaminaModifier = -30; // vanilla -32
	}
});
