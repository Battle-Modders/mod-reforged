::Reforged.HooksMod.hook("scripts/skills/backgrounds/ratcatcher_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 5,
			"pg.rf_large": 0.8,
			"pg.rf_resilient": 0.8,
			"pg.rf_talented": 2,
			"pg.rf_shield": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_trapper"
				],
				"pgc.rf_shared_1": [
					"pg.rf_agile",
					"pg.rf_fast"
				],
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
