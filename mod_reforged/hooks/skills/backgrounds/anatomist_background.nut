::Reforged.HooksMod.hook("scripts/skills/backgrounds/anatomist_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[30, "pg.rf_knave"],
						[70, "pg.rf_trapper"]
					]).roll()
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
				return _collection.getMin() + 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
				return 0.8;

			case "pg.rf_tough":
			case "pg.rf_vigorous":
			case "pg.rf_mace":
			case "pg.rf_power":
			case "pg.rf_shield":
				return 0.75;

			case "pg.rf_tactician":
				return 2;

			case "pg.rf_hammer":
				return 0.5;

			case "pg.special.rf_student":
				return 2;
		}
	}
});
