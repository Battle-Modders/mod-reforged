::Reforged.HooksMod.hook("scripts/skills/backgrounds/crusader_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_devious": 0,
			"pg.rf_fast": 0.5,
			"pg.rf_large": 1,
			"pg.rf_leadership": 0,
			"pg.rf_sturdy": 2,
			"pg.rf_tactician": 0,
			"pg.rf_talented": 0,
			"pg.rf_unstoppable": 2,
			"pg.rf_vicious": 2,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_polearm": 9,
			"pg.rf_spear": 0,

            "pg.special.rf_professional": -1,
            "pg.special.rf_man_of_steel": -1
		};
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
