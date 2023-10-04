::Reforged.HooksMod.hook("scripts/skills/traits/fragile_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 0,
			"pg.rf_resilient": 0.5
		};
	}
});
