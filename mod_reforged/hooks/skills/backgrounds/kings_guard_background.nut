::Reforged.HooksMod.hook("scripts/skills/backgrounds/kings_guard_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [
					"pg.rf_unstoppable"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_medium_armor",
					"pg.rf_heavy_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_shield",
					"pg.rf_swift"
				]
			}
		});
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared_1":
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;

			case "pgc.rf_weapon":
				return _collection.getMin() + 2;
		}
	}}.getPerkGroupCollectionMin;
});
