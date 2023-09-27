::Reforged.HooksMod.hook("scripts/skills/traits/brute_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_trained": 0.5,
			"pg.rf_axe": 1.5,
			"pg.rf_cleaver": 0.66,
			"pg.rf_flail": 2,
			"pg.rf_hammer": 0.66,
			"pg.rf_mace": 1.5,
			"pg.rf_spear": 0.5,
			"pg.rf_sword": 0.8
		};
	}
});
