::Reforged.HooksMod.hook("scripts/skills/traits/weasel_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": -1
		};
	}
});
