::Reforged.HooksMod.hook("scripts/items/weapons/legendary/obsidian_dagger", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 1;
	}}.create;
});
