::mods_hookExactClass("skills/backgrounds/manhunter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_leadership": 2,
			"pg.rf_talented": 2,
			"pg.rf_tactician": 2,
			"pg.rf_vicious": 1.5
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_raider",
				"pg.rf_trapper"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [
				"pg.rf_cleaver"
			],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
