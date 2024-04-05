::Reforged.HooksMod.hook("scripts/skills/traits/irrational_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_back_to_basics": 0
		};
	}
});
