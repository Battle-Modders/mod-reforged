::mods_hookExactClass("skills/backgrounds/nomad_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_tactician": 3,
			"pg.rf_talented": 2,
			"pg.rf_trained": 1.4,
			"pg.rf_unstoppable": 1.5,
			"pg.rf_vicious": 1.5,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_trapper": 2.5
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_raider"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
