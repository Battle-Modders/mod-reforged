::Reforged.HooksMod.hook("scripts/skills/traits/fragile_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_tough": 0
		};
	}
});
