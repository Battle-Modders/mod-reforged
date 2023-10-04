::Reforged.HooksMod.hook("scripts/skills/traits/swift_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 2
		};
	}
});
