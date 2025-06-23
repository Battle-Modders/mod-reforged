::Reforged.HooksMod.hook("scripts/retinue/retinue_manager", function(q) {
	q.m.ValidFollowers <- [];
	q.m.FollowerToolItemCache <- null; // keep a weakref to the item to avoid iteration
	q.create = @(__original) function()
	{
		__original();
		// TODO Disable unused followers
		foreach (follower in this.m.Followers)
		{
			this.m.ValidFollowers.push(follower.getID());
		}

	}

	q.setFollowerItemCache <- function()
	{
		if (!::MSU.isNull(this.m.FollowerToolItemCache))
		{
			return;
		}
		local stash = ::World.Assets.getStash().getItems();
		foreach (index, item in stash)
		{
			if (item != null && item.m.ID == "supplies.rf_follower_tool")
			{
				this.m.FollowerToolItemCache = ::MSU.asWeakTableRef(item);
				return this.m.FollowerToolItemCache.getAmount();
			}
		}
	}

	q.getFollowerToolAmount <- function()
	{
		this.setFollowerItemCache();
		if (!::MSU.isNull(this.m.FollowerToolItemCache))
		{
			return this.m.FollowerToolItemCache.getAmount();
		}
		return 0;
	}

	q.addFollowerToolAmount <- function(_amount)
	{
		// can be negative
		this.setFollowerItemCache();
		if (::MSU.isNull(this.m.FollowerToolItemCache))
		{
			local item = ::new("scripts/items/supplies/rf_follower_tool_item");
			this.World.Assets.getStash().add(item);
			this.m.FollowerToolItemCache = ::MSU.asWeakTableRef(item);
		}
		local newValue = ::Math.max(this.m.FollowerToolItemCache.getAmount() + _amount, 0);
		this.m.FollowerToolItemCache.setAmount(newValue);
	}

	q.onUnlockPerk <- function(_perkID)
	{
		local perkDef = ::Reforged.Retinue.getPerk(_perkID);
		if ("ToolCost" in perkDef)
		{
			this.addFollowerToolAmount(-perkDef.ToolCost);
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
					followerToSpawn.enterTown(townToSpawnIn.getID());
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
		local baseOdds = ::Reforged.Retinue.BasePctForFollowerToSpawnPerDay;
		local renown = ::World.Assets.getBusinessReputation();
		local renownAdd = renown / 100;
		local modifiedOdds = ::Math.min(100, baseOdds + renownAdd);
		local decay = ::Reforged.Retinue.DecayRateForFollowerToSpawnPerDay
		local chance = baseOdds * ::Math.pow(decay, followerCount);
		// TODO remove debug print
		::logInfo("shouldSpawnFollower chance: " + chance)

		return ::Math.rand(0, 100) < chance;
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
		// TODO remove debug print
		::MSU.Log.printData(weightedContainerSpawnProbability.Table);
		::logInfo(weightedContainerSpawnProbability.Total);

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
				weightedContainerTownProbability.setWeight(townID, 0.1);
			}

		}
		_follower.adaptTownWeightsForSpawning(weightedContainerTownProbability);
		// TODO add other factors (origins...)
		// TODO remove debug print
		::MSU.Log.printData(weightedContainerTownProbability.Table);
		::logInfo(weightedContainerTownProbability.Total);

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

