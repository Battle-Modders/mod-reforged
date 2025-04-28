this.rf_old_swordmaster_scenario <- ::inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		local avatarEffect = ::new("scripts/skills/effects/rf_old_swordmaster_scenario_avatar_effect");
		this.m.ID = "scenario.rf_old_swordmaster";
		this.m.Name = "Reforged - Old Swordmaster";
		this.m.Description = "[p=c][img]gfx/ui/events/event_17.png[/img][/p][p]You are a legendary swordmaster, eager to pass on your skills to others! " + ::MSU.Text.colorNegative("Read the text in the intro event for details on how this origin works!") +"\n\n[color=#bcad8c]Teacher:[/color] Upon leveling up, every recruit has a chance to gain a free Sword perk.\n[color=#bcad8c]Swords Only:[/color] Your company can only use swords but gain special bonuses when using them. Ranged Weapons and Banner are allowed.\n[color=#bcad8c]Handpicked:[/color] Limited to " + avatarEffect.m.BrothersMax + " total characters and maximum " + avatarEffect.m.BrothersMaxInCombat + " in battle.\n[color=#bcad8c]Young Blood:[/color] Highly proficient melee backgrounds are not available for hire.\n[color=#bcad8c]Avatar:[/color] If your swordmaster dies, the campaign ends.[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 1;
		this.m.IsFixedLook = true;

		this.m.RF_RebuildPerkTreeAfterSpawn = false;
	}

	function onInit()
	{
		local ambitions = ::World.Ambitions.m.Ambitions;
		for (local i = ambitions.len() - 1; i >= 0; i--)
		{
			switch (ambitions[i].getID())
			{
				case "ambition.hammer_mastery":
				case "ambition.ranged_mastery":
					ambitions.remove(i);
					break;
			}
		}
	}

	function isValid()
	{
		return ::Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local bro = ::World.getPlayerRoster().create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"rf_old_swordmaster_background"
		]);
		bro.getSkills().add(::new("scripts/skills/traits/player_character_trait"));

		local perkScripts = [
			"scripts/skills/perks/perk_rf_fencer",
			"scripts/skills/perks/perk_duelist"
		];

		foreach (pgID in ["pg.rf_swordmaster", "pg.rf_sword"])
		{
			foreach (row in ::DynamicPerks.PerkGroups.findById(pgID).getTree())
			{
				foreach (perkID in row)
				{
					perkScripts.push(::Const.Perks.findById(perkID).Script)
				}
			}
		}

		foreach (script in perkScripts)
		{
			bro.getSkills().add(::Reforged.new(script, function(o) {
				o.m.IsRefundable = false;
			}));
		}

		bro.setPerkTier(7);

		bro.setPlaceInFormation(4);
		bro.getFlags().set("IsPlayerCharacter", true);

 		//bro.getSprite("socket").setBrush("bust_base_crusader"); //custom base
 		//bro.getSprite("socket").setBrush("bust_base_wildmen_01");
		bro.getSprite("miniboss").setBrush("bust_miniboss");
		bro.m.HireTime = ::Time.getVirtualTimeF();
		::World.Assets.addMoralReputation(20);
		::World.Assets.addBusinessReputation(1100);
		::World.Assets.m.Ammo = 0;

		::World.Assets.getStash().add(::new("scripts/items/supplies/cured_venison_item"));
		::World.Assets.getStash().add(::new("scripts/items/weapons/fencing_sword"));
		::World.Assets.getStash().add(::new("scripts/items/weapons/rf_greatsword"));
		::World.Assets.getStash().add(::new("scripts/items/weapons/arming_sword"));
		::World.Assets.getStash().add(::new("scripts/items/weapons/arming_sword"));

		bro.getSkills().add(::new("scripts/skills/effects/rf_old_swordmaster_scenario_avatar_effect"));
		bro.getSkills().add(::new("scripts/skills/effects/rf_old_swordmaster_scenario_exhausted_effect"));
		bro.getSkills().add(::new("scripts/skills/traits/old_trait"));

		foreach (item in bro.getItems().getAllItems())
		{
			bro.getItems().unequip(item);
		}
		bro.getItems().equip(::new("scripts/items/weapons/noble_sword"));
		bro.getItems().equip(::new("scripts/items/armor/noble_mail_armor"));
		bro.getItems().equip(::new("scripts/items/helmets/greatsword_hat"));
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != ::World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = ::World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();

		do
		{
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 1), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 1));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 1), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 1));

			if (::World.isValidTileSquare(x, y))
			{
				local tile = ::World.getTileSquare(x, y);

				if (tile.Type != ::Const.World.TerrainType.Ocean && tile.Type != ::Const.World.TerrainType.Shore && tile.getDistanceTo(randomVillageTile) != 0 && tile.HasRoad)
				{
					randomVillageTile = tile;
					break;
				}
			}
		}
		while (1);

		::World.State.m.Player = ::World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		::World.Assets.updateLook(100); // Eventually we should implement a more robust player party look system in Modular Vanilla
		::World.getCamera().setPos(::World.State.m.Player.getPos());
		::Time.scheduleEvent(::TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_02.ogg"
			], ::Const.Music.CrossFadeTime);
			::World.Events.fire("event.rf_old_swordmaster_scenario_intro");
		}, null);
	}

	function onCombatFinished()
	{
		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			if (bro.getFlags().get("IsPlayerCharacter"))
			{
				return true;
			}
		}

		return false;
	}

	function MV_getPlayerPartyStrengthMult()
	{
		return 2.0;
	}

	function onHired( _bro )
	{
		_bro.getSkills().add(::new("scripts/skills/effects/rf_old_swordmaster_scenario_recruit_effect"));
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];

		foreach (bro in _roster.getAll())
		{
			if (!this.isRecruitValid(bro))
			{
				garbage.push(bro);
				continue;
			}

			// Should be re-enabled once we have a way to make the hiring cost stay between game save/load
			// if (bro.getBackground().getID() == "background.squire" || bro.getBackground().getID() == "background.apprentice")
			// {
			// 	bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 0.5);
			// 	bro.getBaseProperties().DailyWageMult *= 0.5;
			// 	bro.getSkills().update();
			// }
		}

		foreach (bro in garbage)
		{
			_roster.remove(bro);
		}
	}

	function onBuildPerkTree( _perkTree )
	{
		if (_perkTree.hasPerkGroup("pg.rf_sword"))
		{
			foreach (pgID in ::DynamicPerks.PerkGroupCategories.findById("pgc.rf_weapon").getGroups())
			{
				switch (pgID)
				{
					case "pg.rf_sword":
					case "pg.rf_bow":
					case "pg.rf_crossbow":
					case "pg.rf_throwing":
						break;

					default:
						if (_perkTree.hasPerkGroup(pgID))
							_perkTree.removePerkGroup(pgID);
				}
			}

			_perkTree.addPerkGroup("pg.rf_swordmaster");
		}
	}

	function isRecruitValid( _bro )
	{
		return _bro.getBackground().getID() != "background.wildman" && _bro.getBackground().onChangeAttributes().MeleeSkill[0] < 8;
	}
});

