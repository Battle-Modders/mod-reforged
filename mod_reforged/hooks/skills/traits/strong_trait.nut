::mods_hookExactClass("skills/traits/strong_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_sturdy": 3
		};
	}
});
