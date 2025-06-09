::Reforged.HooksMod.hook("scripts/retinue/retinue_manager", function(q) {
	q.getFollowerFromSlot <- function(_idx)
	{
		return this.m.Slots[_idx];
	}

	q.onNewDay = @(__original) function()
	{
		__original();
		this.updateFollowersInTowns();
	}

	q.setFollower = @(__original) function( _slot, _follower )
	{
		if (this.m.Slots[_slot] != null)
			this.m.Slots[_slot].onDismiss();
		__original(_slot, _follower);
		_follower.onHired();
	}

	q.updateFollowersInTowns <- function()
	{
		// check if followers should leave towns, then distributes new followers among towns if necessary

		local currentFollowersInTowns = [];
		local availableToDistribute = [];
		local occupiedTownIDs = [];
		foreach(follower in this.m.Followers)
		{
			if (follower.isInTown())
			{
				currentFollowersInTowns.push(follower);
				occupiedTownIDs.push(follower.getCurrentTownID());
			}
			// Currently can't be distributed into a new town if just left
			else
			{
				availableToDistribute.push(follower);
			}
		}

		local availableTowns = ::World.EntityManager.getSettlements().filter(@(idx, town) !(town.getID() in occupiedTownIDs));
		while (currentFollowersInTowns <= ::Reforged.Retinue.MaxFollowersInTowns
			&& availableToDistribute.len() > 0
			&& availableTowns.len() > 0)
		{
			local chosenFollower = availableToDistribute.remove(availableToDistribute[::Math.rand(0, availableToDistribute.len() - 1)]);
			local chosenTown = availableTowns.remove(availableTowns[::Math.rand(0, availableTowns.len() - 1)]);
			currentFollowersInTowns.push(chosenFollower);
			occupiedTownIDs.push(chosenTown.getID());
			chosenFollower.enterTown(chosenTown);
		}
	}

	q.getFollowersForUI = @() function()
	{
		local ret = [];

		foreach( follower in this.m.Followers )
		{
			ret.push(follower.getUIData());
		}

		return ret;
	}
})

