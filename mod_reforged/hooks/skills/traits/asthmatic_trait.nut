::mods_hookExactClass("skills/traits/asthmatic_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_sturdy": 0.5
		};
	}
});
