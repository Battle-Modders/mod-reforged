::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/thorned_whip", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
	}
});
