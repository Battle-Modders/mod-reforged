::mods_hookExactClass("skills/backgrounds/beast_hunter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 1.2,
			"pg.rf_devious": 1.5,
			"pg.rf_fast": 1.2,
			"pg.rf_talented": 4,
			"pg.rf_vicious": 2,
			"pg.rf_dagger": 2
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_trapper"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
