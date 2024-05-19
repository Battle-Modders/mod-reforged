::Reforged.HooksMod.hook("scripts/skills/traits/tough_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_tough": -1
		};
	}
});
