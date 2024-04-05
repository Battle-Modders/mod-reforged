::Reforged.HooksMod.hook("scripts/skills/traits/fearless_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 5,
			"pg.rf_unstoppable": -1
		};
	}
});
