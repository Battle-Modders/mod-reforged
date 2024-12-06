/*
This action competes with the vanilla build_bandit_camp_action.
build_bandit_camp_action usually stops once 9 bandit camps exist; this includes our new bandit forts.
So as days progress, this action will prevent smaller bandit camps from appearing until only 3 (9 - MaximumCampLimit) smaller bandit camps can be on the map.
*/
this.rf_build_bandit_camp_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		// Config
		BaseCampAmount = 1,	// This many camps can be present from Day 1
		DaysForAdditionalCamp = 50,		// For every these amount of days, an additional Camp may spawn
		MaximumCampLimit = 6,	// This is the maximum amount of camps that can ever be present
	},
	function create()
	{
		this.m.ID = "rf_build_bandit_camp_action";
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local settlements = _faction.getSettlements();
		local banditForts = 0;
		foreach (banditCamp in settlements)
		{
			if (banditCamp.getTypeID() == "location.rf_bandit_fort")
			{
				banditForts++;
			}
		}

		if (banditForts >= this.getMaximumCamps())
		{
			return;
		}

		this.m.Score = 2;
	}

	function onExecute( _faction )
	{
		local minDistToSettlements = 10;
		local maxDistToSettlements = 25;
		local minDistToEnemyLocations = 7;
		local minDistToAlliedLocations = 7;
		local minY = 0.2;
		local maxY = 0.75;

		local tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [
			::Const.World.TerrainType.Mountains,
			::Const.World.TerrainType.Snow
		], minDistToSettlements, maxDistToSettlements, 1000, minDistToEnemyLocations, minDistToAlliedLocations, null, minY, maxY);

		if (tile != null)
		{
			local camp = ::World.spawnLocation("scripts/entity/world/locations/rf_bandit_fort_location", tile.Coords);
			if (camp != null)	// This creation might fail for some reason. Not sure though as it's in the exe
			{
				local maxDistance = 15;
				local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), maxDistance, ::Const.BanditBanners);
				camp.onSpawned();
				camp.setBanner(banner);
				_faction.addSettlement(camp, false);
			}
		}
	}

// New Functions
	function getMaximumCamps()
	{
		local maximumCamps = this.m.BaseCampAmount + (::World.getTime().Days / this.m.DaysForAdditionalCamp);
		return ::Math.min(this.m.MaximumCampLimit, maximumCamps);
	}
});

