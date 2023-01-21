::mods_hookExactClass("skills/backgrounds/monk_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 0,
			"pg.rf_leadership": 7.5,
			"pg.rf_resilient": 0.5,
			"pg.rf_sturdy": 0.5,
			"pg.rf_unstoppable": 0,
			"pg.rf_vicious": 0
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [
				"pg.rf_light_armor",
				"pg.rf_medium_armor"
			],
			"pgc.rf_fighting_style": []
		});

		this.m.Excluded.push("trait.swindler");
	}
});
