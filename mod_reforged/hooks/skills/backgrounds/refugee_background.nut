::Reforged.HooksMod.hook("scripts/skills/backgrounds/refugee_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 0.5,
			"pg.rf_leadership": 0.5,
			"pg.rf_resilient": 0.5,
			"pg.rf_sturdy": 2,
			"pg.rf_talented": 0.5,
			"pg.rf_unstoppable": 0.5
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_pauper"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
