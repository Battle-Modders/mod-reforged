::mods_hookExactClass("skills/traits/fainthearted_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 0.5,
			"pg.rf_resilient": 0.5,
			"pg.rf_unstoppable": 0.5
		};
	}
});
