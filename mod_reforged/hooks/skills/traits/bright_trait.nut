::Reforged.HooksMod.hook("scripts/skills/traits/bright_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_discovered_talent": 2,
			"pg.special.rf_gifted": 2,
			"pg.special.rf_rising_star": 2,
			"pg.special.rf_student": 2
		};
	}
});
