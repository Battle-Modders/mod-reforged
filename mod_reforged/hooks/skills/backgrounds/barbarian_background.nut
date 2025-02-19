::Reforged.HooksMod.hook("scripts/skills/backgrounds/barbarian_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.BeardChance = 90;
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_trained": 0,
			"pg.rf_unstoppable": 3,
			"pg.rf_vicious": 2,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_polearm": 0,
			"pg.rf_ranged": 0
		};

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					::MSU.Class.WeightedContainer([
						[20, "pg.rf_laborer"],
						[50, "pg.rf_raider"],
						[10, "pg.rf_trapper"],
						[20, "pg.rf_wildling"]
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
				return _collection.getMin() + 2;
		}
	}
});
