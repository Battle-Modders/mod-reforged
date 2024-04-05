::Reforged.HooksMod.hook("scripts/skills/backgrounds/juggler_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 3,
			"pg.rf_fast": 3,
			"pg.rf_flail": 3,
			"pg.rf_polearm": 1.5,
			"pg.rf_heavy_armor": 0
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
                    "pg.rf_knave"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_swift"
				]
			}
		});
	}
});
