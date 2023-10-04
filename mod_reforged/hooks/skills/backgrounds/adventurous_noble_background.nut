::Reforged.HooksMod.hook("scripts/skills/backgrounds/adventurous_noble_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
            "pg.rf_devious": 0,
            "pg.rf_leadership": 20,
            "pg.rf_tactician": 6,
            "pg.rf_trained": 5,
            "pg.rf_bow": 0,
            "pg.rf_crossbow": 0,
            "pg.rf_ranged": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_noble"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
