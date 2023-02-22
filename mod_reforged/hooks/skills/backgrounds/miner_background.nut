::mods_hookExactClass("skills/backgrounds/miner_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 2,
			"pg.rf_sturdy": 0.165,
			"pg.rf_talented": 0.5,
			"pg.rf_flail": 1.5,
			"pg.rf_mace": 1.5
		};
		this.m.PerkTree = ::DynamicPerks.Class.PerkTree({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_hammer"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
