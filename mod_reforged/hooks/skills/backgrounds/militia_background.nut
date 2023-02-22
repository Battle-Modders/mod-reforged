::mods_hookExactClass("skills/backgrounds/militia_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_talented": 2
		};
		this.m.PerkTree = ::DynamicPerks.Class.PerkTree({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_militia"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
