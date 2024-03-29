::Reforged.HooksMod.hook("scripts/skills/backgrounds/peddler_southern_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 1.2,
			"pg.rf_devious": 1.5,
			"pg.rf_fast": 1.2,
			"pg.rf_sturdy": 2,
			"pg.rf_talented": 2,
			"pg.rf_trained": 0.5,
			"pg.rf_unstoppable": 0.5,
			"pg.rf_vicious": 0.5,
			"pg.rf_power": 0.5,
			"pg.rf_swift": 0.5
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
