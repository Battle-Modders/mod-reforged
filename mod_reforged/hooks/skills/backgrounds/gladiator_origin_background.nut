::Reforged.HooksMod.hook("scripts/skills/backgrounds/gladiator_origin_background", function(q) {
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
			case "pgc.rf_shared_1":
			case "pgc.rf_armor":
				return _collection.getMin() + 1;

			case "pgc.rf_weapon":
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 2;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_bow":
			case "pg.rf_crossbow":
				return 0;

			case "pg.rf_trained":
				return 3;

			case "pg.rf_unstoppable":
				return 2;

			case "pg.special.rf_professional":
				return -1;
		}
	}}.getPerkGroupMultiplier;
});
