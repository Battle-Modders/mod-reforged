::mods_hookExactClass("skills/backgrounds/gambler_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 2,
			"pg.rf_devious": 2,
			"pg.rf_fast": 2,
			"pg.rf_leadership": 7.5,
			"pg.rf_tactician": 4,
			"pg.rf_shield": 0.5
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
