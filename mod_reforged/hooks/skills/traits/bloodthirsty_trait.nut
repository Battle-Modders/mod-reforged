::Reforged.HooksMod.hook("scripts/skills/traits/bloodthirsty_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_vicious": -1
		};
	}
});
