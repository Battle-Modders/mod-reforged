this.rf_random_trio <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.rf_random_trio";
		this.m.Name = "Reforged - Random Trio";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p][p]A random start into the world, without any particular advantages or disadvantages.\n\n[color=#bcad8c]Random Start:[/color] Start with a roster of 3 random brothers.\n[color=#bcad8c]Talented:[/color] Your starting characters are level 2 and always have 2 stars in their talents.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 1;
	}

	function onSpawnAssets()
	{
		local roster = ::World.getPlayerRoster();

		// Spawn 3 Brothers with random backgrounds
		for (local i = 1; i <= 3; ++i)
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = ::Time.getVirtualTimeF();
			bro.setPlaceInFormation(i + 2);
			bro.improveMood(1.5, "Joined a mercenary company");

			// Background, Stars, Level
			bro.setStartValuesEx(::Const.MV_HireableCharacterBackgrounds);
			bro.m.Attributes = [];
			for (local i = 0; i < bro.m.Talents.len(); ++i)
			{
				if (bro.m.Talents[i] != 0)
				{
					bro.m.Talents[i] = 2;
				}
			}
			bro.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
			bro.m.PerkPoints = 1;
			bro.m.LevelUps = 1;
			bro.m.Level = 2;
		}

		// Items
		::World.Assets.getStash().add(::new("scripts/items/weapons/knife"));
		::World.Assets.getStash().add(::new("scripts/items/weapons/wooden_stick"));
		::World.Assets.getStash().add(::new("scripts/items/shields/wooden_shield_old"));
		::World.Assets.getStash().add(::new("scripts/items/tools/throwing_net"));
		::World.Assets.getStash().add(::new("scripts/items/supplies/ground_grains_item"));
		::World.Assets.getStash().add(::new("scripts/items/supplies/ground_grains_item"));
	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local allSettlements = ::World.EntityManager.getSettlements()

		for (local i = 0; i != allSettlements.len(); ++i)
		{
			randomVillage = allSettlements[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = ::World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;

		while (true)
		{
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 4), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 4), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (::World.isValidTileSquare(x, y))
			{
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore || tile.IsOccupied)
				{
					continue;
				}

				if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
					continue;
				}

				local path = ::World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);
				if (!path.isEmpty())
				{
					randomVillageTile = tile;
					break;
				}
			}
		}

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function ( _tag )
		{
			::Music.setTrackList(::Const.Music.IntroTracks, ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.rf_random_trio_scenario_intro");
		}, null);
	}
});

