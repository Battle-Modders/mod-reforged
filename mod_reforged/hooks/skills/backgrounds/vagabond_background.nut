::mods_hookExactClass("skills/backgrounds/vagabond_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 0.66,
			"pg.rf_leadership": 0.5,
			"pg.rf_resilient": 0.5,
			"pg.rf_sturdy": 2,
			"pg.rf_unstoppable": 2
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_laborer"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
