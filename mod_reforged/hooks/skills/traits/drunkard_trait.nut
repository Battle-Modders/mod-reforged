::Reforged.HooksMod.hook("scripts/skills/traits/drunkard_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0.25,
			"pg.rf_trained": 0.5,
			"pg.special.rf_marksmanship": 0
		};
	}
});
