::Reforged.HooksMod.hook("scripts/skills/backgrounds/gambler_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 3,
			"pg.rf_fast": 3,
			"pg.special.rf_leadership": 7.5,
			"pg.rf_tactician": 4,
			"pg.rf_shield": 0.5
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
		switch (_category.getID())
		{
			case "pgc.rf_shared_1":
				return _category.getMin() + 1;

			case "pgc.rf_weapon":
			case "pgc.rf_armor":
				return _category.getMin() - 1;
		}
	}
});
