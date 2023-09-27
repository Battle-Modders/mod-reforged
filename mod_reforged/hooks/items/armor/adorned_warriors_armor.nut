::Reforged.HooksMod.hook("scripts/items/armor/adorned_warriors_armor", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 3000;
	}
});
