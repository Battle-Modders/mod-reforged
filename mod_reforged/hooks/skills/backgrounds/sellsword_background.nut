::Reforged.HooksMod.hook("scripts/skills/backgrounds/sellsword_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[50, "pg.rf_soldier"],
						[30, "pg.rf_raider"],
						[20, "DynamicPerks_NoPerkGroup"]
					]).roll()
				],
				"pgc.rf_shared_1": [
					"pg.rf_trained"
				],
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
				return _collection.getMin() + 2;

			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_vicious":
				return 2;

			case "pg.rf_tactician":
				return 3;
		}
	}
});
