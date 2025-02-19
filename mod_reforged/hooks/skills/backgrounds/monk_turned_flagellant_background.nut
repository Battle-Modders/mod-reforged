::Reforged.HooksMod.hook("scripts/skills/backgrounds/monk_turned_flagellant_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 10,
			"pg.rf_vigorous": 3,
			"pg.rf_vicious": 0
			"pg.rf_heavy_armor": 0,
			"pg.rf_power": 2,
			"pg.rf_shield": 0,
			"pg.rf_swift": 2
		};

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
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
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}
});
