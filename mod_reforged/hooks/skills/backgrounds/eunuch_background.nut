::Reforged.HooksMod.hook("scripts/skills/backgrounds/eunuch_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.BeardChance = 0;
		this.m.PerkTreeMultipliers = {
			"pg.rf_tactician": 4,
			"pg.special.rf_student": 2
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
			case "pgc.rf_shared_1":
				return _collection.getMin() + 1;

			case "pgc.rf_weapon":
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}
});
