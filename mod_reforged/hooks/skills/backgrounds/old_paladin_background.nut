::mods_hookExactClass("skills/backgrounds/old_paladin_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 0,
			"pg.rf_large": 0.5,
			"pg.rf_sturdy": 0.5,
			"pg.rf_tactician": 4,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_throwing": 0,
			"pg.rf_ranged": 0,

			"pg.special.rf_professional": -1
		};
		this.m.PerkTree = ::DynamicPerks.Class.PerkTree({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [
					"pg.rf_leadership"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
