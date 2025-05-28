::Reforged.HooksMod.hook("scripts/skills/backgrounds/companion_2h_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[40, "pg.rf_laborer"],
						[30, "pg.rf_raider"],
						[30, "DynamicPerks_NoPerkGroup"]
					]).roll()
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_power"
				]
			}
		});
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared_1":
				return _collection.getMin() + 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		if (::Reforged.Skills.getPerkGroupMultiplier_MeleeOnly(_groupID, _perkTree) == 0)
			return 0;

		switch (_groupID)
		{
			case "pg.rf_agile":
			case "pg.rf_fast":
				return 0.75;

			case "pg.special.rf_leadership":
			case "pg.rf_tactician":
			case "pg.rf_dagger":
			case "pg.rf_spear":
				return 0;

			case "pg.rf_vicious":
				return 1.5;

			case "pg.rf_sword":
				return 0.9;

			case "pg.rf_heavy_armor":
				return 3;
		}
	}}.getPerkGroupMultiplier;
});
