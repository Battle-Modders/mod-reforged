::Reforged.HooksMod.hook("scripts/skills/traits/gluttonous_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.75,
			"pg.rf_fast": 0.75,
			"pg.rf_large": 2
		};
	}
});
