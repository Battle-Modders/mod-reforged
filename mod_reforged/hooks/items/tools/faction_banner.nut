::Reforged.HooksMod.hook("scripts/items/tools/faction_banner", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 6;
	}
});
