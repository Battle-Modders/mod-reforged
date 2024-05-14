::Reforged.HooksMod.hook("scripts/skills/backgrounds/lindwurm_slayer_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 2,
			"pg.rf_fast": 2,
			"pg.special.rf_leadership": 0,
			"pg.rf_vicious": 3,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_ranged": 0
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared_1":
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;

			case "pgc.rf_weapon":
				return _collection.getMin() + 2;
		}
	}
});
