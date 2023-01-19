::mods_hookExactClass("skills/traits/brave_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 2,
			"pg.rf_unstoppable": 2
		};
	}
});
