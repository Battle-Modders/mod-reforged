::Reforged.HooksMod.hook("scripts/skills/backgrounds/belly_dancer_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 2,
			"pg.rf_fast": 2,
			"pg.rf_large": 0.66,
			"pg.rf_leadership": 0,
			"pg.rf_resilient": 0.75,
			"pg.rf_sturdy": 0.66,
			"pg.rf_talented": 2,
			"pg.rf_vicious": 2,
			"pg.rf_dagger": 2,
			"pg.rf_hammer": 0.5,
			"pg.rf_mace": 0.75,
			"pg.rf_spear": 0.75,
			"pg.rf_shield": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_devious"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_light_armor",
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_swift"
				]
			}
		});
	}
});
