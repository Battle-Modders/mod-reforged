::Reforged.HooksMod.hook("scripts/skills/backgrounds/beggar_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0
		};

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_pauper"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					::MSU.Class.WeightedContainer([
						[50, "pg.rf_light_armor"],
						[50, "pg.rf_medium_armor"]
					])
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
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}
});
