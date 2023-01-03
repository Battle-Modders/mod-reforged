::mods_hookExactClass("skills/backgrounds/bowyer_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_light_armor": 1.5,
			"pg.rf_crossbow": 3,
			"pg.rf_throwing": 2
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [
				"pg.rf_bow"
			],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": [
				"pg.rf_ranged"
			]
		});
	}
});
