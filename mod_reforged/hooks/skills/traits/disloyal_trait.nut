::mods_hookExactClass("skills/traits/disloyal_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 2
		};
	}
});
