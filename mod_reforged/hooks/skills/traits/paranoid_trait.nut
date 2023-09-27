::Reforged.HooksMod.hook("scripts/skills/traits/paranoid_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.25,
			"pg.rf_fast": 0.25,
			"pg.rf_tactician": 0
		};
	}
});
