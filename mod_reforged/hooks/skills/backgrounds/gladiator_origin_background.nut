::mods_hookExactClass("skills/backgrounds/gladiator_origin_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_leadership": 0,
			"pg.rf_tactician": 5,
			"pg.rf_talented": 6,
			"pg.rf_trained": 3,
			"pg.rf_unstoppable": 2,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_ranged": 0
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
                ::MSU.Class.WeightedContainer([
                    [20, "pg.rf_laborer"],
                    [30, "pg.rf_raider"],
                    [50, "pg.rf_soldier"]
                ]),
                ::MSU.Class.WeightedContainer([
                	[50, "pg.rf_trapper"],
                	[50, "DPF_NoPerkGroup"]
                ])
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});

		this.m.Excluded.push("trait.swindler");
	}
});
