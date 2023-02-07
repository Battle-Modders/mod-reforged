::mods_hookExactClass("skills/backgrounds/flagellant_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 10,
			"pg.rf_resilient": 3,
			"pg.rf_sturdy": 3,
			"pg.rf_vicious": 3,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_power": 2,
			"pg.rf_ranged": 0,
			"pg.rf_shield": 0,
			"pg.rf_swift": 2
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
