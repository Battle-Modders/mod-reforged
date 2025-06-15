::Reforged.HooksMod.hook("scripts/retinue/retinue_manager", function(q) {
	q.m.ValidFollowers <- [];
	q.create = @(__original) function()
	{
		__original();
		// TODO Disable unused followers
		foreach (follower in this.m.Followers)
		{
			this.m.ValidFollowers.push(follower.getID());
		}

	}
	q.getFollowerFromSlot <- function(_idx)
	{
		return this.m.Slots[_idx];
	}

	q.onNewDay = @(__original) function()
	{
		__original();
		if (this.shouldSpawnFollower())
		{
			local result = this.getFollowerToSpawn()
			if (result != null)
			{
				result.Follower.enterTown(result.Town.getID());
			}
		}

		// TODO REMOVE DEBUG
		foreach(town in ::World.EntityManager.getSettlements())
		{
			if (town.getName() == "Lichtmark")
			{
				this.getFollower("follower.cook").enterTown(town.getID());
				this.getFollower("follower.scout").enterTown(town.getID());
				::logConsole("Cook entered Lichtmark")
			}
		}
	}

	q.setFollower = @(__original) function( _slot, _follower )
	{
		if (this.m.Slots[_slot] != null)
			this.m.Slots[_slot].onDismiss();
		__original(_slot, _follower);
		_follower.onHired();
	}

	q.shouldSpawnFollower <- function()
	{
		local followerCount = this.m.Followers.reduce(@(_, _follower) _follower.m.CurrentTownTable.len());
		local baseOdds = ::Reforged.Retinue.BaseOddsForFollowerToSpawnPerDay;
		local decay = 0.9;
		local odds = baseOdds * ::Math.pow(decay, followerCount);
		return ::Math.rand(0, 100) < odds;
	}

	q.getFollowerToSpawn <- function()
	{
		// check if followers should leave towns, then distributes new followers among towns if necessary
		local weightedContainerSpawnProbability = ::MSU.Class.WeightedContainer();
		weightedContainerSpawnProbability.addArray(this.m.Followers.map(@(_follower) [_follower.m.BaseSpawnChance, _follower.getID()]));

		foreach(follower in this.m.Followers)
		{
			follower.adaptFollowerSpawnChance(weightedContainerSpawnProbability);

		}
		// TODO add other factors (origins...)
		local chosenFollowerID = weightedContainerSpawnProbability.roll();
		if (chosenFollowerID == null)
		{
			return null;
		}
		chosenFollower = this.getFollower(chosenFollowerID);


		local weightedContainerTownProbability = ::MSU.Class.WeightedContainer();
		weightedContainerTownProbability.addMany(1, ::World.EntityManager.getSettlements().map(@(_town) _town.getID()));
		foreach(follower in this.m.Followers)
		{
			foreach(townID in follower.getCurrentTownIDs())
			{
				weightedContainerTownProbability.set(townID, 0.1);
			}

		}
		chosenFollower.adaptSpawnInTownChance(weightedContainerTownProbability);
		// TODO add other factors (origins...)

		local chosenTownID = weightedContainerTownProbability.roll();
		if (chosenTownID == null)
		{
			return null;
		}

		return {
			Follower = chosenFollower,
			Town = this.World.getEntityByID(chosenTownID)
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

	q.onPlayerEnterTown <- function(_town)
	{
		foreach(follower in this.m.Followers)
		{
			follower.onPlayerEnterTown(_town);
		}
	}
})

