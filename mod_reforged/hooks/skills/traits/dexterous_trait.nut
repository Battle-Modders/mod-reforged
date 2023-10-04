::Reforged.HooksMod.hook("scripts/skills/traits/dexterous_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 2
		};
	}
});
