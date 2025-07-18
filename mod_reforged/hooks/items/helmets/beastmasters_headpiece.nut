::Reforged.HooksMod.hook("scripts/items/helmets/beastmasters_headpiece", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Vision = 0; // vanilla -1
	}}.create;
});
