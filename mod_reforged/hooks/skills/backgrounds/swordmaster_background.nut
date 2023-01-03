::mods_hookExactClass("skills/backgrounds/swordmaster_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_devious": 0,
			"pg.rf_fast": 0.5,
			"pg.rf_large": 0.25,
			"pg.rf_leadership": 15,
			"pg.rf_resilient": 1.5,
			"pg.rf_sturdy": 0.25,
			"pg.rf_tactician": 2,
			"pg.rf_talented": 0,

            "perk.rf_professional": -1
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_soldier",
				"pg.rf_swordmaster"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [
				"pg.rf_sword"
			],
			"pgc.rf_armor": [
				"pg.rf_medium_armor"
			],
			"pgc.rf_fighting_style": [
				"pg.rf_power": 0,
				"pg.rf_swift": 0
			]
		});
	}
});
