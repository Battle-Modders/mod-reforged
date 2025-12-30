::Reforged.HooksMod.hook("scripts/items/tools/throwing_net", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.RangeMax = 2; // vanilla is 3
	}}.create;
});
