::Reforged.HooksMod.hook("scripts/skills/traits/optimist_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_unstoppable": 2
		};
	}
});
