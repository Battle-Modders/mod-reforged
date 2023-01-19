::mods_hookExactClass("skills/traits/cocky_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"pg.fast": 1.5
		};
	}
});
