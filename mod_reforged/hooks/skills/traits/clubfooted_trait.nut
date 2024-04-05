::Reforged.HooksMod.hook("scripts/skills/traits/clubfooted_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0,
			"pg.rf_fast": 0
		};
	}
});
