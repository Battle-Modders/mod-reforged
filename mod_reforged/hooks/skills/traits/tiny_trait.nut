::Reforged.HooksMod.hook("scripts/skills/traits/tiny_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 2,
			"pg.rf_large": 0
		};
	}
});
