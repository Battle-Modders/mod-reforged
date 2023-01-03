::mods_hookExactClass("skills/backgrounds/old_gladiator_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_devious": 3,
			"pg.rf_fast": 0.5,
			"pg.rf_large": 0.5,
			"pg.rf_leadership": 0,
			"pg.rf_sturdy": 0.5,
			"pg.rf_tactician": 10,
			"pg.rf_unstoppable": 2,
			"pg.rf_vicious": 2,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_generalist": 0,
			"pg.rf_ranged": 0,
			"pg.rf_trapper": 10,

            "perk.rf_professional": -1
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_soldier"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
