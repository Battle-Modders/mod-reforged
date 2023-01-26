::mods_hookExactClass("skills/backgrounds/fisherman_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 0.66,
			"pg.rf_sturdy": 0.66,
			"pg.rf_talented": 0.5,
			"pg.rf_unstoppable": 1.5
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_laborer",
				"pg.rf_trapper"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
