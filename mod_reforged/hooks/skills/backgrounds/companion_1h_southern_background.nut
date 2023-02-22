::mods_hookExactClass("skills/backgrounds/companion_1h_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 0.75,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_ranged": 0
		};
		this.m.PerkTree = ::DynamicPerks.Class.PerkTree({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
	                ::MSU.Class.WeightedContainer([
	                    [60, "pg.rf_militia"],
	                    [10, "pg.rf_soldier"],
	                    [30, "DynamicPerks_NoPerkGroup"]
	                ])
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_spear"
				],
				"pgc.rf_armor": [
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_shield"
				]
			}
		});
	}
});
