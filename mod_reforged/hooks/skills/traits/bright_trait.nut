::Reforged.HooksMod.hook("scripts/skills/traits/bright_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_talented": 10
		};
		this.m.Excluded.push("trait.swindler");
	}
});
