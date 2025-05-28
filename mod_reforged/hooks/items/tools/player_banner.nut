::Reforged.HooksMod.hook("scripts/items/tools/player_banner", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 6;
	}}.create;
});
