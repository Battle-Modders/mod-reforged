::Reforged.HooksMod.hook("scripts/skills/traits/quick_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_fast": -1
		};
	}
});
