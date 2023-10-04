::Reforged.HooksMod.hook("scripts/skills/traits/clumsy_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 0.5
		};
	}
});
