::mods_hookExactClass("skills/backgrounds/witchhunter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_leadership": 10,
			"pg.rf_tactician": 3,
			"pg.rf_unstoppable": 2,
			"pg.rf_vicious": 2,
			"pg.rf_bow": 2
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [
				"pg.rf_crossbow"
			],
			"pgc.rf_armor": [
				"pg.rf_light_armor"
			],
			"pgc.rf_fighting_style": [
				"pg.rf_ranged"
			]
		});
	}
});
