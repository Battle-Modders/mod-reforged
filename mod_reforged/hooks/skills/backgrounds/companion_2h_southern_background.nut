::mods_hookExactClass("skills/backgrounds/companion_2h_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_devious": 0,
			"pg.rf_fast": 0.5,
			"pg.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_vicious": 1.5,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0,
			"pg.rf_sword": 0.8,
			"pg.rf_throwing": 0,
			"pg.rf_ranged": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
	                ::MSU.Class.WeightedContainer([
	                    [40, "pg.rf_laborer"],
	                    [30, "pg.rf_raider"],
	                    [30, "DPF_NoPerkGroup"]
	                ])
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_power"
				]
			}
		});
	}
});
