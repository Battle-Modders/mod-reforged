::Reforged.HooksMod.hook("scripts/skills/traits/brave_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 2,
			"pg.rf_unstoppable": 2
		};
	}
});
