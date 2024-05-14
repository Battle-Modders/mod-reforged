::Reforged.HooksMod.hook("scripts/skills/backgrounds/old_gladiator_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_fast": 0.5,
			"pg.rf_strong": 0.5,
			"pg.special.rf_leadership": 0,
			"pg.rf_vigorous": 0.5,
			"pg.rf_tactician": 10,
			"pg.rf_unstoppable": 2,
			"pg.rf_vicious": 2,
			"pg.rf_dagger": 0
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeOnly);
		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier",
					"pg.rf_trapper"
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
			case "pgc.rf_shared_1":
			case "pgc.rf_weapon":
			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}
});
