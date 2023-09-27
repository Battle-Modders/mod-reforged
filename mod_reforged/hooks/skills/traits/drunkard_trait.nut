::Reforged.HooksMod.hook("scripts/skills/traits/drunkard_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_leadership": 0.25,
			"pg.rf_talented": 0.25,
			"pg.rf_trained": 0.5
		};
	}
});
