::mods_hookExactClass("skills/backgrounds/retired_soldier_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 0.25,
			"pg.rf_leadership": 10,
			"pg.rf_resilient": 0.25,
			"pg.rf_sturdy": 0.5,
			"pg.rf_tactician": 7.5,
			"pg.rf_light_armor": 0.5,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_ranged": 0
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
