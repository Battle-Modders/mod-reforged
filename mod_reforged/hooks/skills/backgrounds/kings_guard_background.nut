::Reforged.HooksMod.hook("scripts/skills/backgrounds/kings_guard_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeOnly);
		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [
					"pg.rf_unstoppable"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_medium_armor",
					"pg.rf_heavy_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_shield",
					"pg.rf_swift"
				]
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_category.getID())
		{
			case "pgc.rf_shared_1":
			case "pgc.rf_fighting_style":
				return _category.getMin() + 1;

			case "pgc.rf_weapon":
				return _category.getMin() + 2;
		}
	}
});
