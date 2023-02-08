::mods_hookExactClass("skills/backgrounds/squire_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 10,
			"pg.rf_tactician": 3,
			"pg.rf_talented": 3,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
	                ::MSU.Class.WeightedContainer([
	                    [50, "pg.rf_soldier"],
	                    [50, "DynamicPerks_NoPerkGroup"]
	                ]),
	                ::MSU.Class.WeightedContainer([
	                   [30, "pg.special.rf_professional"],
	                   [70, "DynamicPerks_NoPerkGroup"]
	                ])
				],
				"pgc.rf_shared_1": [
					"pg.rf_trained"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
