::Reforged.HooksMod.hook("scripts/skills/traits/iron_jaw_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_vigorous": 2
		};
	}
});
