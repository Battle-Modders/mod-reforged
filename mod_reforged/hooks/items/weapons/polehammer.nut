::Reforged.HooksMod.hook("scripts/items/weapons/polehammer", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
	}
});
