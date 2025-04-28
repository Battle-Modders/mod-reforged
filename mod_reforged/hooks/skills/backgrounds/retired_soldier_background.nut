::Reforged.HooksMod.hook("scripts/skills/backgrounds/retired_soldier_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_medium_armor",
					"pg.rf_heavy_armor"
				],
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

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_professional":
				return -1;

			case "pg.rf_bow":
			case "pg.rf_crossbow":
				return 0;

			case "pg.rf_tough":
				return 0.25;

			case "pg.special.rf_leadership":
				return 10;

			case "pg.rf_tactician":
				return 15;

			case "pg.rf_vigorous":
				return 0.5;
		}
	}
});
