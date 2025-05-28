::Reforged.HooksMod.hook("scripts/skills/backgrounds/flagellant_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
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
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
				return 5;

			case "pg.rf_vigorous":
			case "pg.rf_vicious":
				return 3;

			case "pg.rf_heavy_armor":
			case "pg.rf_crossbow":
			case "pg.rf_shield":
				return 0;

			case "pg.rf_power":
			case "pg.rf_swift":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
