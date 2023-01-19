::mods_hookExactClass("skills/traits/sure_footing_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 2
		};
	}
});
