::Reforged.HooksMod.hook("scripts/items/shields/legendary/gilders_embrace_shield", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ReachIgnore = 3;
	}}.create;
});
