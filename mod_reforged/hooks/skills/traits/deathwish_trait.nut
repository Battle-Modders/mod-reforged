::mods_hookExactClass("skills/traits/deathwish_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_resilient": 2,
			"pg.rf_unstoppable": 3
		};
	}
});
