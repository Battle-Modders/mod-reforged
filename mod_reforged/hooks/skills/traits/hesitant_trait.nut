::Reforged.HooksMod.hook("scripts/skills/traits/hesitant_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_fast": 0
		};
	}
});
