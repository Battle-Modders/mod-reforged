::Reforged.HooksMod.hook("scripts/skills/traits/pessimist_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_unstoppable": 0.5
		};
	}
});
