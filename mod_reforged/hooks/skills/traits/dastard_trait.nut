::Reforged.HooksMod.hook("scripts/skills/traits/dastard_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_unstoppable": 0
		};
	}
});
