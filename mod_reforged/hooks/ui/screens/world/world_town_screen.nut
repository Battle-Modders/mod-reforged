::Reforged.HooksMod.hook("scripts/ui/screens/world/world_town_screen", function(q) {
	::logInfo("world_town_screen")
	// Add support to show retinue from town
	q.onRetinueButtonPressed <- function()
	{
		::World.State.town_screen_main_dialog_module_onRetinueButtonClicked();
	}


	// Add the IDs of the retinue in this town to the town asset info
	local function getFollowersInTown(_currentTownID)
	{
		local followersInTown = [];
		foreach (follower in ::World.Retinue.m.Followers)
		{
			local followerTown = follower.getCurrentTown();
			if (followerTown && followerTown.getID() == _currentTownID)
			{
				followersInTown.push(follower.getID());
			}
		}
		return followersInTown;
	}
	// first showing
	q.queryTownInformation = @(__original) function()
	{
		local ret = __original();
		if (this.m.Town != null)
		{
			ret["Assets"]["FollowersInTown"] <- getFollowersInTown(this.getTown().getID());
		}
		return ret;
	}

	q.queryAssetsInformation = @(__original) function()
	{
		local ret = __original();
		ret["FollowersInTown"] <- getFollowersInTown(this.getTown().getID());
		return ret;
	}
});
