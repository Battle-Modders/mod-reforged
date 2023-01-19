::mods_hookExactClass("skills/traits/dastard_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 0,
			"pg.rf_resilient": 0.25,
			"pg.rf_unstoppable": 0.25
		};
	}
});
