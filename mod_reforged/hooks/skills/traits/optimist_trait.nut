::mods_hookExactClass("skills/traits/optimist_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_unstoppable": 2
		};
	}
});
