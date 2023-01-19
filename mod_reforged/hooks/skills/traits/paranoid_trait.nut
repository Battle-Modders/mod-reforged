::mods_hookExactClass("skills/traits/paranoid_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.25,
			"pg.rf_fast": 0.25,
			"pg.rf_tactician": 0
		};
	}
});
