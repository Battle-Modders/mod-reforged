::mods_hookExactClass("skills/traits/survivor_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_resilient": -1
		};
	}
});
