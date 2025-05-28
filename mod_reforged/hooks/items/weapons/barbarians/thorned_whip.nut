::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/thorned_whip", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 1;
	}}.create;
});
