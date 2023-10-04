::Reforged.HooksMod.hook("scripts/items/weapons/javelin", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}
});
