::mods_hookExactClass("skills/traits/tiny_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 2,
			"pg.rf_large": 0
		};
	}
});
