::mods_hookExactClass("skills/traits/fearless_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 5,
			"pg.rf_unstoppable": 3
		};
	}
});
