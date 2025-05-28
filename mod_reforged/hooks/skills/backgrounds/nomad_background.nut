::Reforged.HooksMod.hook("scripts/skills/backgrounds/nomad_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[50, "pg.rf_knave"],
						[50, "pg.rf_raider"]
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
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_bow":
			case "pg.rf_crossbow":
				return 0;

			case "pg.rf_ranged":
				return 0.5;

			case "pg.rf_tactician":
				return 3;

			case "pg.rf_trained":
				return 1.4;

			case "pg.rf_unstoppable":
			case "pg.rf_vicious":
				return 1.5;
		}
	}}.getPerkGroupMultiplier;
});
