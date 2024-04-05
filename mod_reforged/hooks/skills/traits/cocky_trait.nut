::Reforged.HooksMod.hook("scripts/skills/traits/cocky_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_fast": 1.5,
			"pg.rf_trained": 0.5,
			"pg.rf_shield": 0
		};
	}
});
