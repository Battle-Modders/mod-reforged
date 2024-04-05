::Reforged.HooksMod.hook("scripts/skills/traits/night_blind_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_marksmanship": 0
		};
	}
});
