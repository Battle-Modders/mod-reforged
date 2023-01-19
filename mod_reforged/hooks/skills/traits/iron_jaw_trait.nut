::mods_hookExactClass("skills/traits/iron_jaw_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_resilient": -1,
			"pg.rf_sturdy": 2
		};
	}
});
