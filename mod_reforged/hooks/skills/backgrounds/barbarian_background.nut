::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 0,
			"pg.rf_leadership": 0,
			"pg.rf_resilient": 2,
			"pg.rf_tactician": 0,
			"pg.rf_trained": 0,
			"pg.rf_unstoppable": 3,
			"pg.rf_vicious": 2,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_polearm": 0,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_ranged": 0,
			"pg.rf_trapper": 2
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
                ::MSU.Class.WeightedContainer([
                    [20, "pg.rf_laborer"],
                    [60, "pg.rf_raider"],
                    [20, "pg.rf_wildling"]
                ])
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
