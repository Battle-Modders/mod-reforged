::mods_hookExactClass("skills/traits/fragile_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 0,
			"pg.rf_resilient": 0.5
		};
	}
});
