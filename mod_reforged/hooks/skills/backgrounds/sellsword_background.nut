::mods_hookExactClass("skills/backgrounds/sellsword_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_leadership": 2,
			"pg.rf_tactician": 3,
			"pg.rf_talented": 3,
			"pg.rf_vicious": 2,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,

            "pg.special.rf_professional": -1
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
                ::MSU.Class.WeightedContainer([
                    [50, "pg.rf_soldier"],
                    [30, "pg.rf_raider"],
                    [20, "DPF_NoPerkGroup"]
                ])
			],
			"pgc.rf_shared_1": [
				"pg.rf_trained"
			],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
