::Reforged.HooksMod.hook("scripts/skills/backgrounds/minstrel_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_large": 0.75,
			"pg.rf_leadership": 7.5,
			"pg.rf_resilient": 0.25,
			"pg.rf_sturdy": 0.25,
			"pg.rf_talented": 5
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_light_armor",
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
