::Reforged.HooksMod.hook("scripts/skills/traits/strong_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_sturdy": 3
		};
	}
});
