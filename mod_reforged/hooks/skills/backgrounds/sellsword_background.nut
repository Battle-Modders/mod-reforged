::Reforged.HooksMod.hook("scripts/skills/backgrounds/sellsword_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 2,
			"pg.rf_tactician": 3,
			"pg.rf_vicious": 2
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					::MSU.Class.WeightedContainer([
						[50, "pg.rf_soldier"],
						[30, "pg.rf_raider"],
						[20, "DynamicPerks_NoPerkGroup"]
					])
				],
				"pgc.rf_shared_1": [
					"pg.rf_trained"
				],
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

			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}
});
