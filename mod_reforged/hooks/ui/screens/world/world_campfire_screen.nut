::Reforged.HooksMod.hook("scripts/ui/screens/world/world_campfire_screen", function(q) {
	q.queryAssetsInformation = @(__original) function()
	{
		local ret = __original();
		local currentTown = ::World.State.getCurrentTown();
		ret["CurrentTownID"] <- currentTown == null ? null : currentTown.getID();
		return ret;
	}
});
