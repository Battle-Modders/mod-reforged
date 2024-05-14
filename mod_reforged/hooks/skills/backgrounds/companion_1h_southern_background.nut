::Reforged.HooksMod.hook("scripts/skills/backgrounds/companion_1h_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_ranged": 0.33
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
	                ::MSU.Class.WeightedContainer([
	                    [60, "pg.rf_militia"],
	                    [10, "pg.rf_soldier"],
	                    [30, "DynamicPerks_NoPerkGroup"]
	                ])
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_spear"
				],
				"pgc.rf_armor": [
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_shield"
				]
			}
		});
	}


	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared_1":
				return _collection.getMin() + 1;
		}
	}
});
