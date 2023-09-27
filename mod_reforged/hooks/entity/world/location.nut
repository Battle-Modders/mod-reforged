::Reforged.HooksMod.hook("scripts/entity/world/location", function(q) {
	q.onLeave = @(__original) function()
	{
		__original();
		::World.State.setPause(true);
	}
});
