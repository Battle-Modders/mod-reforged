::Reforged.HooksMod.hook("scripts/skills/backgrounds/companion_ranged_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_shield": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [
					"pg.rf_agile"
				],
				"pgc.rf_weapon": [
					"pg.rf_bow",
					"pg.rf_crossbow",
					"pg.rf_throwing"
				],
				"pgc.rf_armor": [
					"pg.rf_light_armor",
					"pg.rf_medium_armor"
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
			case "pgc.rf_shared_1":
				return _collection.getMin() + 1;
		}
	}
});
