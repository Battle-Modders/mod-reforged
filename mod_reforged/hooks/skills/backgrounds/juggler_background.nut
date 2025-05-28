::Reforged.HooksMod.hook("scripts/skills/backgrounds/juggler_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_knave"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_swift"
				]
			}
		});
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_heavy_armor":
				return 0;

			case "pg.rf_agile":
			case "pg.rf_fast":
			case "pg.rf_flail":
				return 3;

			case "pg.rf_polearm":
				return 1.5;

		}
	}}.getPerkGroupMultiplier;
});
