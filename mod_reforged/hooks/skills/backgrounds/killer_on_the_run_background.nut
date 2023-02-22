::mods_hookExactClass("skills/backgrounds/killer_on_the_run_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 3,
			"pg.rf_leadership": 0,
			"pg.rf_dagger": 2,
			"pg.rf_flail": 2,
			"pg.rf_polearm": 1.25
		};
		this.m.PerkTree = ::DynamicPerks.Class.PerkTree({
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
