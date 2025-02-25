::Reforged.HooksMod.hook("scripts/skills/backgrounds/gladiator_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_trapper",
					::MSU.Class.WeightedContainer([
						[20, "pg.rf_laborer"],
						[30, "pg.rf_raider"],
						[50, "pg.rf_soldier"]
					]),
					::MSU.Class.WeightedContainer([
						[10, "pg.special.rf_professional"],
						[90, "DynamicPerks_NoPerkGroup"]
					])
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
				local fights = ::Math.rand(5, 15);
				flags.set("ArenaFightsWon", fights);
				flags.set("ArenaFights", fights);

				if (fights < 12)
				{
					this.getContainer().add(::new("scripts/skills/traits/arena_fighter_trait"));
				}
				else
				{
					this.getContainer().add(::new("scripts/skills/traits/arena_veteran_trait"));
				}
			}
		}

		__original();
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_bow":
			case "pg.rf_crossbow":
			case "pg.rf_dagger":
				return 0;

			case "pg.rf_tactician":
				return 5;

			case "pg.rf_trained":
				return 3;

			case "pg.rf_unstoppable":
				return 2;
		}
	}
});
