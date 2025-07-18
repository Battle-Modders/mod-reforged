::Reforged.HooksMod.hook("scripts/items/helmets/oriental/southern_helmet_with_coif", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Vision = -1; // vanilla -2
	}}.create;
});
