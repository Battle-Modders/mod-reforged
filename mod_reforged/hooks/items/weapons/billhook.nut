::Reforged.HooksMod.hook("scripts/items/weapons/billhook", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 6;
	}}.create;
});
