::mods_hookExactClass("skills/backgrounds/butcher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 0.66,
			"pg.rf_resilient": 0.66,
			"pg.rf_sturdy": 0.66,
			"pg.rf_talented": 0.5,
			"pg.rf_vicious": 3,
			"pg.rf_axe": 1.25,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 2,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 1.25,
			"pg.rf_ranged": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_cleaver"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
