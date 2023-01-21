::mods_hookExactClass("skills/backgrounds/pimp_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 1.2,
			"pg.rf_fast": 1.2,
			"pg.rf_leadership": 2,
			"pg.rf_sturdy": 2,
			"pg.rf_talented": 3,
			"pg.rf_trained": 0.75,
			"pg.rf_unstoppable": 0.75,
			"pg.rf_vicious": 0.75,
			"pg.rf_power": 0.75,
			"pg.rf_swift": 0.75
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});

		this.m.Excluded.push("trait.swindler");
	}
});
