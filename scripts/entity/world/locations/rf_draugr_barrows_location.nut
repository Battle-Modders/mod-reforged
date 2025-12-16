this.rf_draugr_barrows_location <- ::inherit("scripts/entity/world/location", {
	m = {},
	function create()
	{
		this.location.create();
		this.m.TypeID = "location.rf_draugr_barrows";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.rf_barrows";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.m.IsShowingDefenders = false;

		this.m.OnEnter = "event.location.rf_draugr_location_enter";

		this.setDefenderSpawnList(::Const.World.Spawn.RF_DraugrDefenders);
		this.m.Resources = 250;
	}

	// This is where you put named items
	function onSpawned()
	{
		this.m.Name = ::World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.RF_DraugrBarrows);
		this.m.Description = ::World.EntityManager.RF_getUniqueLocationDescription(::Const.World.RF_LocationDescriptions.RF_DraugrBarrows);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		local treasure = [
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/ancient_gold_coins_item",
			"loot/bead_necklace_item",
			"loot/bone_figurines_item"
		];

		this.dropMoney(::Math.rand(500, 1000), _lootTable);
		this.dropTreasure(::Math.rand(2, 4), treasure, _lootTable);
	}

	function createDefenders()
	{
		this.location.createDefenders();

		// Guarantee at least one huskarl
		local hasHuskarl = false;
		foreach (t in this.m.Troops)
		{
			if (t.ID == ::Const.EntityType.RF_DraugrHuskarl)
			{
				hasHuskarl = true;
				break;
			}
		}

		if (!hasHuskarl)
		{
			::Const.World.Common.addTroop(this, { Type = ::Const.World.Spawn.Troops.RF_DraugrHuskarl });
		}
	}

	function onInit()
	{
		this.location.onInit();
		local isOnSnow = this.getTile().Type == ::Const.World.TerrainType.Snow;

		for (local i = 0; i != 6; i++)
		{
			if (this.getTile().hasNextTile(i) && this.getTile().getNextTile(i).Type == ::Const.World.TerrainType.Snow)
			{
				isOnSnow = true;
				break;
			}
		}

		this.addSprite("body").setBrush("world_rf_draugr_barrows_01" + (isOnSnow ? "_snow" : ""));
	}
});
