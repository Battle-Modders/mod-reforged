::Reforged.HooksMod.hook("scripts/ui/screens/world/world_campfire_screen", function(q) {
	q.queryAssetsInformation = @(__original) function()
	{
		local ret = __original();
		local currentTown = ::World.State.getCurrentTown();
		ret["CurrentTownID"] <- currentTown == null ? null : currentTown.getID();
		ret["FollowerTools"] <- {};
		foreach (item in ::World.Assets.getStash().getItems())
		{
			if (item != null && item.m.ID == "supplies.rf_follower_tool")
			{
				ret["FollowerTools"][item.getFollowerTypeID()] <- item.getAmount();
			}
		}
		return ret;
	}
});
