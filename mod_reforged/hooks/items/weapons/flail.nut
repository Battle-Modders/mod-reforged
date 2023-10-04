::Reforged.HooksMod.hook("scripts/items/weapons/flail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
	}
});
