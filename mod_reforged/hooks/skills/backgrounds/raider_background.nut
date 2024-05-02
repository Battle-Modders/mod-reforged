::Reforged.HooksMod.hook("scripts/skills/backgrounds/raider_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 1.4,
			"pg.rf_vicious": 2,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_raider"
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
			case "pgc.rf_weapon":
			case "pgc.rf_fighting_style":
				return _category.getMin() + 1;
		}
	}
});
