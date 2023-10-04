::Reforged.HooksMod.hook("scripts/skills/traits/survivor_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_resilient": -1
		};
	}
});
