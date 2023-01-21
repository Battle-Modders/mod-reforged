::mods_hookExactClass("skills/backgrounds/paladin_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 2,
			"pg.rf_devious": 0,
			"pg.rf_fast": 2,
			"pg.rf_leadership": 20,
			"pg.rf_tactician": 4,
			"pg.rf_talented": 2,
			"pg.rf_unstoppable": 3,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_throwing": 0,
			"pg.rf_ranged": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});

		this.m.Excluded.push("trait.swindler");
	}
});
