::Reforged.HooksMod.hook("scripts/items/weapons/flail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 4;
	}}.create;
});
