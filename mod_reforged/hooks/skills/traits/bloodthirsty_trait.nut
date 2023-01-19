::mods_hookExactClass("skills/traits/bloodthirsty_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.rf_vicious": -1
		};
	}
});
