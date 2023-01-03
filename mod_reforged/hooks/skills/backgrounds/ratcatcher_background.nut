::mods_hookExactClass("skills/backgrounds/ratcatcher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 5,
			"pg.rf_large": 0.8,
			"pg.rf_resilient": 0.8,
			"pg.rf_talented": 2,
			"pg.rf_shield": 0,
			"pg.rf_swift": 3
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
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
			"pgc.rf_fighting_style": []
		});
	}
});
