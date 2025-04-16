::Reforged.HooksMod.hook("scripts/skills/backgrounds/lindwurm_slayer_background", function(q) {
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
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared_1":
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;

			case "pgc.rf_weapon":
				return _collection.getMin() + 2;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
			case "pg.rf_fast":
				return 2;

			case "pg.special.rf_leadership":
			case "pg.rf_bow":
			case "pg.rf_crossbow":
			case "pg.rf_dagger":
			case "pg.rf_ranged":
				return 0;

			case "pg.rf_vicious":
				return 3;
		}
	}
});
