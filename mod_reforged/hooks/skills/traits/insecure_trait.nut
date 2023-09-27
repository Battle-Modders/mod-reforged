::Reforged.HooksMod.hook("scripts/skills/traits/insecure_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_unstoppable": 0
		};
	}
});
