::Reforged.HooksMod.hook("scripts/skills/traits/sure_footing_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 2
		};
	}
});
