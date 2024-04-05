::Reforged.HooksMod.hook("scripts/skills/backgrounds/bowyer_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_light_armor": 1.5,
			"pg.rf_heavy_armor": 0
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.RangedBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_bow"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_ranged"
				]
			}
		});
	}
});
