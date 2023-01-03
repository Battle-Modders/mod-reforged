::mods_hookExactClass("skills/backgrounds/lumberjack_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 2,
			"pg.rf_leadership": 2,
			"pg.rf_resilient": 2,
			"pg.rf_sturdy": 2
		};
		this.m.PerkTree = ::new(::DPF.Class.PerkTree).init(null, {
			"pgc.rf_exclusive_1": [
				"pg.rf_laborer"
			],
			"pgc.rf_shared_1": [],
			"pgc.rf_weapon": [
				"pg.rf_axe"
			],
			"pgc.rf_armor": [],
			"pgc.rf_fighting_style": []
		});
	}
});
