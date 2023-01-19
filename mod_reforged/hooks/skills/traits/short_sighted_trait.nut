::mods_hookExactClass("skills/traits/short_sighted_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"perk.rf_marksmanship": 0.33
		};
	}
});
