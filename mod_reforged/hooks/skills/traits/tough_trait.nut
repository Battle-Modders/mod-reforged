::mods_hookExactClass("skills/traits/tough_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 2
		};
	}
});
