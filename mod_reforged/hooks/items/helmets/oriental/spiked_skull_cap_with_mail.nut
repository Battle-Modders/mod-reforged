::Reforged.HooksMod.hook("scripts/items/helmets/oriental/spiked_skull_cap_with_mail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Vision = 0; // vanilla -1
	}}.create;
});
