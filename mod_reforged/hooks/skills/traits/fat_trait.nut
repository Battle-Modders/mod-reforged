::mods_hookExactClass("skills/traits/fat_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_fast": 0.5,
			"pg.rf_large": -1,
			"pg.rf_sturdy": 0.5
		};
	}
});
