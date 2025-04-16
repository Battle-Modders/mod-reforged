::Reforged.HooksMod.hook("scripts/skills/backgrounds/bowyer_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_bow"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_ranged"
				]
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_light_armor":
				return 1.5;

			case "pg.rf_heavy_armor":
				return 0;
		}
	}
});
