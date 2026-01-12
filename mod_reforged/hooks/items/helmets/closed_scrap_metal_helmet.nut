::Reforged.HooksMod.hook("scripts/items/helmets/closed_scrap_metal_helmet", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Vision = -3; // vanilla -2
	}}.create;
});
