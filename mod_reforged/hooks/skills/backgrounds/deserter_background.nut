::Reforged.HooksMod.hook("scripts/skills/backgrounds/deserter_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 2,
			"pg.rf_leadership": 0,
			"pg.rf_tactician": 4,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,

			"pg.special.rf_professional": -1
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
