::mods_hookExactClass("skills/traits/drunkard_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_talented": 0
		};
	}
});
