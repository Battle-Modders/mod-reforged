::Reforged.HooksMod.hook("scripts/skills/backgrounds/old_gladiator_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier",
					"pg.rf_trapper"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared_1":
			case "pgc.rf_weapon":
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}

	q.onAdded = @(__original) function()
	{
		if (this.m.IsNew)
		{
			local flags = this.getContainer().getActor().getFlags();
			if (!flags.has("ArenaFights"))
			{
				local fights = ::Math.rand(15, 25);
				flags.set("ArenaFightsWon", fights);
				flags.set("ArenaFights", fights);

				this.getContainer().add(::new("scripts/skills/traits/arena_veteran_trait"));
			}
		}

		__original();
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_dagger":
			case "pg.rf_bow":
			case "pg.rf_crossbow":
				return 0;

			case "pg.rf_agile":
			case "pg.rf_fast":
			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 0.5;

			case "pg.rf_tactician":
				return 10;

			case "pg.rf_unstoppable":
			case "pg.rf_vicious":
				return 2;
		}
	}
});
