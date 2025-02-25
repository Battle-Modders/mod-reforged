::Reforged.HooksMod.hook("scripts/skills/traits/asthmatic_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_vigorous": 0,
			"pg.special.rf_man_of_steel": 0
		};
	}
});
