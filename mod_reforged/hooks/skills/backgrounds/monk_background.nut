::Reforged.HooksMod.hook("scripts/skills/backgrounds/monk_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_vigorous": 0.5,
			"pg.rf_unstoppable": 0,
			"pg.rf_vicious": 0,
			"pg.rf_heavy_armor": 0.5,

			"pg.special.rf_leadership": -1
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeBackground);

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
			case "pgc.rf_fighting_style":
				return _collection.getMin() - 1;
		}
	}
});
