::Reforged.HooksMod.hook("scripts/skills/traits/fat_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.5,
			"pg.rf_fast": 0.5,
			"pg.rf_large": -1,
			"pg.rf_sturdy": 0.5
		};
	}
});
