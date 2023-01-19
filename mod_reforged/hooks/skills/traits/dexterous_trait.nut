::mods_hookExactClass("skills/traits/dexterous_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 2
		};
	}
});
