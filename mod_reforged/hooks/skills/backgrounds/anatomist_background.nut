::Reforged.HooksMod.hook("scripts/skills/backgrounds/anatomist_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0.8,
			"pg.rf_strong": 0.75,
			"pg.rf_tactician": 2,
			"pg.rf_vigorous": 0.75,
			"pg.rf_hammer": 0.5,
			"pg.rf_mace": 0.75,
			"pg.rf_power": 0.75,
			"pg.rf_shield": 0.75,
			"pg.special.rf_student": 2,
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
	                ::MSU.Class.WeightedContainer([
	                    [30, "pg.rf_knave"],
	                    [70, "pg.rf_trapper"]
	                ])
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
});
