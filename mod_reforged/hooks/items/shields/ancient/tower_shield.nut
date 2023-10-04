::Reforged.HooksMod.hook("scripts/items/shields/ancient/tower_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ReachIgnore = 3;
	}
});
