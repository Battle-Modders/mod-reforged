::Reforged.HooksMod.hook("scripts/skills/backgrounds/anatomist_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_large": 0.75,
			"pg.rf_leadership": 0.8,
			"pg.rf_resilient": 0.75,
			"pg.rf_shield": 0.75,
			"pg.rf_sturdy": 0.75,
			"pg.rf_tactician": 4,
			"pg.rf_talented": 4
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_trapper"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
