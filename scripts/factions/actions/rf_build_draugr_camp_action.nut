this.rf_build_draugr_camp_action <- ::inherit("scripts/factions/faction_action", {
	m = {
		MinY = 0.8, // Spawn camps at a minimum of this Y coordinate on world map
		NumSettlements = 5, // Number of settlements to spawn
		NumSettlementsCrisisAdd = 3 // Number of additional settlements to spawn during crisis
	},
	function create()
	{
		this.m.ID = "rf_build_draugr_camp_action";
		this.m.IsRunOnNewCampaign = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local numSettlements = this.m.NumSettlements;
		if (::World.FactionManager.isUndeadScourge() && ::World.FactionManager.getGreaterEvilStrength() >= 20.0)
		{
			numSettlements += this.m.NumSettlementsCrisisAdd;
		}

		if (_faction.getSettlements().len() >= numSettlements)
			return;

		this.m.Score = 2;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local camp = this.getCamp(_faction);
		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, ::Const.RF_DraugrBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}
	}

	function getCamp( _faction )
	{
		local hasFane = false;
		foreach (s in _faction.getSettlements())
		{
			if (s.getTypeID() == "location.rf_draugr_fane")
			{
				hasFane = true;
				break;
			}
		}

		// Guarantee at least 1 Fane at all times.
		local locationToSpawn;
		if (!hasFane)
		{
			locationToSpawn = "scripts/entity/world/locations/rf_draugr_fane_location";
		}
		else
		{
			locationToSpawn = ::MSU.Class.WeightedContainer([
				[3, "scripts/entity/world/locations/rf_draugr_barrows_location"],
				[2, "scripts/entity/world/locations/rf_draugr_crypt_location"],
				[1, "scripts/entity/world/locations/rf_draugr_fane_location"]
			]).roll();
		}

		local tile;
		switch (locationToSpawn)
		{
			case "scripts/entity/world/locations/rf_draugr_barrows_location":
				if (::World.FactionManager.isUndeadScourge())
					tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [::Const.World.TerrainType.Mountains], 6, 14, 1000, 7, 7, null, this.m.MinY);
				else
					tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [::Const.World.TerrainType.Mountains], 7, 20, 1000, 7, 7, null, this.m.MinY);
				break;

			case "scripts/entity/world/locations/rf_draugr_crypt_location":
				if (::World.FactionManager.isUndeadScourge())
					tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [], 8, 18, 1000, 7, 7, null, this.m.MinY);
				else
					tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, [], 10, 20, 1000, 7, 7, null, this.m.MinY);
				break;

			case "scripts/entity/world/locations/rf_draugr_fane_location":
				// Exclude all terrain except Mountains
				local excludedTerrain = clone ::Const.World.TerrainType;
				delete excludedTerrain.Mountains;
				delete excludedTerrain.COUNT;
				excludedTerrain = ::MSU.Table.values(excludedTerrain);

				if (::World.FactionManager.isUndeadScourge())
					tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, excludedTerrain, 8, 18, 1000, 7, 7, null, this.m.MinY);
				else
					tile = this.getTileToSpawnLocation(::Const.Factions.BuildCampTries, excludedTerrain, 10, 30, 1000, 7, 7, null, this.m.MinY);
				break;
		}

		if (tile != null)
		{
			return ::World.spawnLocation(locationToSpawn, tile.Coords);
		}
	}
});

