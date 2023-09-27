::Reforged.HooksMod.hook("scripts/skills/traits/disloyal_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 2
		};
	}
});
