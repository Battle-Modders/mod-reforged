this.rf_draugr_fane_location <- ::inherit("scripts/entity/world/location", {
	m = {},
	function create()
	{
		this.location.create();
		this.m.TypeID = "location.rf_draugr_fane";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.rf_barrows";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.m.IsShowingDefenders = false;

		this.m.OnEnter = "event.location.rf_draugr_location_enter";

		this.setDefenderSpawnList(::Const.World.Spawn.RF_DraugrFane);
		this.m.Resources = 600;
	}

	function onSpawned()
	{
		this.m.Name = ::World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.RF_DraugrFane);
		this.m.Description = ::World.EntityManager.RF_getUniqueLocationDescription(::Const.World.RF_LocationDescriptions.RF_DraugrFane);
		this.location.onSpawned();
		this.__guaranteeNamedItem();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		local treasure = [
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/ancient_gold_coins_item",
			"loot/ancient_gold_coins_item",
			"loot/gemstones_item",
			"loot/gemstones_item",
			"jeweled_crown_item"
		];

		this.dropMoney(::Math.rand(3000, 6000), _lootTable);
		this.dropTreasure(::Math.rand(5, 7), treasure, _lootTable);
	}

	function onInit()
	{
		this.location.onInit();
		this.addSprite("body").setBrush("world_rf_draugr_fane_01");
	}

	// If this location's Loot doesn't already have at least one named item,
	// then adds a random one to it.
	function __guaranteeNamedItem()
	{
		foreach (item in this.m.Loot)
		{
			if (item.isItemType(::Const.Items.ItemType.Named))
			{
				return;
			}
		}

		// We don't care about the type of named item.
		local namedItems = clone ::Const.Items.NamedWeapons;
		namedItems.extend(::Const.Items.NamedShields);
		namedItems.extend(::Const.Items.NamedHelmets);
		namedItems.extend(::Const.Items.NamedArmors);

		if (this.m.NamedShieldsList != null)
		{
			namedItems.extend(this.m.NamedShieldsList);
			namedItems.extend(this.m.NamedShieldsList);
		}
		if (this.m.NamedArmorsList != null)
		{
			namedItems.extend(this.m.NamedArmorsList);
			namedItems.extend(this.m.NamedArmorsList);
		}
		if (this.m.NamedWeaponsList != null)
		{
			namedItems.extend(this.m.NamedWeaponsList);
			namedItems.extend(this.m.NamedWeaponsList);
		}
		if (this.m.NamedHelmetsList != null)
		{
			namedItems.extend(this.m.NamedHelmetsList);
			namedItems.extend(this.m.NamedHelmetsList);
		}

		this.m.Loot.add(::new("scripts/items/" + ::MSU.Array.rand(namedItems)))
	}
});
