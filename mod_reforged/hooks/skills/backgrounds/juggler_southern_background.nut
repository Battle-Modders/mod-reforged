::mods_hookExactClass("skills/backgrounds/juggler_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 3,
			"pg.rf_devious": 1.5,
			"pg.rf_fast": 3,
			"pg.rf_talented": 3,
			"pg.rf_flail": 3,
			"pg.rf_polearm": 1.5,
			"pg.rf_swift": 5
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
