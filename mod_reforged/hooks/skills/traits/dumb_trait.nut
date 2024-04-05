::Reforged.HooksMod.hook("scripts/skills/traits/drunkard_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_discovered_talent": 0,
			"pg.special.rf_gifted": 0,
			"pg.special.rf_rising_star": 0,
			"pg.special.rf_student": 0
		};
	}
});
