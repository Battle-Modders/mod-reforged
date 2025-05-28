::Reforged.HooksMod.hook("scripts/skills/backgrounds/gladiator_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					"pg.rf_trapper",
					::MSU.Class.WeightedContainer([
						[20, "pg.rf_laborer"],
						[30, "pg.rf_raider"],
						[50, "pg.rf_soldier"]
					]).roll(),
					::MSU.Class.WeightedContainer([
						[10, "pg.special.rf_professional"],
						[90, "DynamicPerks_NoPerkGroup"]
					]).roll()
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_weapon":
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}}.getPerkGroupCollectionMin;

	q.onAdded = @(__original) { function onAdded()
	{
		// The PlayerRoster check is to prevent adding the traits to gladiators from the start of the gladiator origin
		// because they get their own traits manually added during onSpawnAssets
		if (this.m.IsNew && ::World.getPlayerRoster().getAll().find(this.getContainer().getActor().get()) == null)
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
	}}.onAdded;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
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
	}}.getPerkGroupMultiplier;
});
