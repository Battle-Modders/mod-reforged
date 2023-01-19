::mods_hookExactClass("skills/traits/drunkard_trait", function (o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeMultipliers = {
			"perk.rf_marksmanship": 3
		};
	}
});
