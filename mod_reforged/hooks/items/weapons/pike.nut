::Reforged.HooksMod.hook("scripts/items/weapons/pike", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 7;
	}}.create;
});
