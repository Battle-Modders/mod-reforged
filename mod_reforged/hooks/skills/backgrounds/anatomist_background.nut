::mods_hookExactClass("skills/backgrounds/anatomist_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_large": 0.75,
			"pg.rf_leadership": 0.8,
			"pg.rf_resilient": 0.75,
			"pg.rf_shield": 0.75,
			"pg.rf_sturdy": 0.75,
			"pg.rf_tactician": 4,
			"pg.rf_talented": 4
		};
		this.m.PerkTree = ::DynamicPerks.Class.PerkTree({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_trapper"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
