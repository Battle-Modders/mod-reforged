::mods_hookExactClass("skills/backgrounds/historian_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_tactician": 4,
			"pg.rf_trained": 4
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
