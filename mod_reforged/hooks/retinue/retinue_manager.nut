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

	q.setFollower = @(__original) function( _slot, _follower )
	{
		if (this.m.Slots[_slot] != null)
			this.m.Slots[_slot].onDismiss();
		__original(_slot, _follower);
		_follower.onHired();
	}

	q.onNewDay = @(__original) function()
	{
		__original();
		this.checkSpawnFollower();
	}

	q.checkSpawnFollower <- function()
	{
		if (this.shouldSpawnFollower())
		{
			local followerToSpawn = this.getFollowerToSpawn();
			if (followerToSpawn != null)
			{
				local townToSpawnIn = this.getTownToSpawnFollowerIn(followerToSpawn);
				if (townToSpawnIn != null)
				{
					followerToSpawn.enterTown(townToSpawnIn)
				}
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
		local weightedContainerSpawnProbability = ::MSU.Class.WeightedContainer();
		weightedContainerSpawnProbability.addArray(this.m.Followers.map(@(_follower) [_follower.m.BaseSpawnChance, _follower.getID()]));

		foreach(follower in this.m.Followers)
		{
			follower.adaptFollowerSpawnChance(weightedContainerSpawnProbability);

		}
		// TODO add other factors (origins...)
		local chosenFollowerID = weightedContainerSpawnProbability.roll();
		return chosenFollowerID == null ? null : this.getFollower(chosenFollowerID);
	}

	q.getTownToSpawnFollowerIn <- function(_follower)
	{
		local weightedContainerTownProbability = ::MSU.Class.WeightedContainer();
		weightedContainerTownProbability.addMany(1, ::World.EntityManager.getSettlements().map(@(_town) _town.getID()));
		foreach(follower in this.m.Followers)
		{
			foreach(townID in follower.getCurrentTownIDs())
			{
				weightedContainerTownProbability.set(townID, 0.1);
			}

		}
		_follower.adaptSpawnInTownChance(weightedContainerTownProbability);
		// TODO add other factors (origins...)

		local chosenTownID = weightedContainerTownProbability.roll();
		return chosenTownID == null ? null : this.World.getEntityByID(chosenTownID);
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

