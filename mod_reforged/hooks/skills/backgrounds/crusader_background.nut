::Reforged.HooksMod.hook("scripts/skills/backgrounds/crusader_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_fast": 0.5,
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_vigorous": 2,
			"pg.rf_dagger": 0,
			"pg.rf_polearm": 0,
			"pg.rf_spear": 0,

            "pg.special.rf_man_of_steel": -1
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeOnly);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_sword"
				],
				"pgc.rf_armor": [
					"pg.rf_medium_armor",
					"pg.rf_heavy_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_shield"
				]
			}
		});
	}
});
