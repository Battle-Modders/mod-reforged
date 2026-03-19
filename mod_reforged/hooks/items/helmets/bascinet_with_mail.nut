::Reforged.HooksMod.hook("scripts/items/helmets/bascinet_with_mail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Vision = -1; // vanilla -2
	}}.create;
});
