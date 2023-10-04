::Reforged.HooksMod.hook("scripts/skills/backgrounds/assassin_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 4,
			"pg.rf_fast": 4,
			"pg.rf_large": 0.66,
			"pg.rf_leadership": 0,
			"pg.rf_resilient": 0.75,
			"pg.rf_sturdy": 0.66,
			"pg.rf_talented": 4,
			"pg.rf_unstoppable": 3,
			"pg.rf_vicious": 3,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 3,
			"pg.rf_hammer": 0.5,
			"pg.rf_mace": 0.75,
			"pg.rf_spear": 0.75,
			"pg.rf_ranged": 0,
			"pg.rf_shield": 0,
			"pg.rf_swift": 3
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_trapper"
				],
				"pgc.rf_shared_1": [
					"pg.rf_devious"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_light_armor",
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_swift"
				]
			}
		});
	}
});
