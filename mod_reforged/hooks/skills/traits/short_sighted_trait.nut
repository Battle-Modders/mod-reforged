::Reforged.HooksMod.hook("scripts/skills/traits/short_sighted_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"perk.rf_marksmanship": 0.33
		};
	}
});
