::Reforged.HooksMod.hook("scripts/skills/traits/cocky_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.fast": 1.5
		};
	}
});
