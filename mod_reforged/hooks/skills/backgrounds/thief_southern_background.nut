::Reforged.HooksMod.hook("scripts/skills/backgrounds/thief_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 3,
			"pg.rf_fast": 3,
			"pg.rf_resilient": 1.2,
			"pg.rf_talented": 2,
			"pg.rf_dagger": 6
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [
					"pg.rf_devious"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_swift"
				]
			}
		});
	}
});
