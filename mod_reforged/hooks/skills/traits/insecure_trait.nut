::mods_hookExactClass("skills/traits/insecure_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_unstoppable": 0
		};
	}
});
