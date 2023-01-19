::mods_hookExactClass("skills/traits/greedy_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 2,
			"pg.rf_vicious": 2
		};
	}
});
