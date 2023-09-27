::Reforged.HooksMod.hook("scripts/skills/traits/deathwish_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_resilient": 2,
			"pg.rf_unstoppable": 3
		};
	}
});
