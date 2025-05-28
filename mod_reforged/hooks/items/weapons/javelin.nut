::Reforged.HooksMod.hook("scripts/items/weapons/javelin", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 0;
	}}.create;
});
