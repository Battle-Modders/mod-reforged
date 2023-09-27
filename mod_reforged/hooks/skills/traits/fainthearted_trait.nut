::Reforged.HooksMod.hook("scripts/skills/traits/fainthearted_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 0.5,
			"pg.rf_resilient": 0.5,
			"pg.rf_unstoppable": 0.5
		};
	}
});
