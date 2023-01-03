::mods_hookExactClass("skills/backgrounds/servant_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 1.2,
			"pg.rf_fast": 1.2,
			"pg.rf_large": 0.75,
			"pg.rf_resilient": 0.75,
			"pg.rf_sturdy": 0.75,
			"pg.rf_talented": 0.5
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
