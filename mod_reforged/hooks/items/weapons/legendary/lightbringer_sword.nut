::Reforged.HooksMod.hook("scripts/items/weapons/legendary/lightbringer_sword", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 4;
	}}.create;
});
