::Reforged.HooksMod.hook("scripts/skills/traits/dastard_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 0,
			"pg.rf_resilient": 0.25,
			"pg.rf_unstoppable": 0.25
		};
	}
});
