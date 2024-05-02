::Reforged.HooksMod.hook("scripts/skills/backgrounds/crucified_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_vigorous": 2,
			"pg.rf_dagger": 0,
			"pg.rf_polearm": 0,
			"pg.rf_spear": 0,
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
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
		switch (_category.getID())
		{
			case "pgc.rf_shared_1":
				return _category.getMin() + 1;

			case "pgc.rf_weapon":
				return _category.getMin() + 2;
		}
	}
});
