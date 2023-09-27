::Reforged.HooksMod.hook("scripts/skills/traits/drunkard_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"perk.rf_marksmanship": 3
		};
	}
});
