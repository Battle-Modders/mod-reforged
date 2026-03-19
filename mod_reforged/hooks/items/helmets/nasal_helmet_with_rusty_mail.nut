::Reforged.HooksMod.hook("scripts/items/helmets/nasal_helmet_with_rusty_mail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Vision = -1; // vanilla -2
	}}.create;
});
