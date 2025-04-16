::Reforged.HooksMod.hook("scripts/skills/backgrounds/poacher_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[40, "pg.rf_bow"],
						[60, "pg.rf_crossbow"]
					]).roll()
				],
				"pgc.rf_armor": [
					"pg.rf_light_armor"
				],
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

	q.getPerkGroupMultiplier = @() function ( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_bow":
			case "pg.rf_crossbow":
			case "pg.rf_throwing":
				return 2.0;
		}
	}
});
