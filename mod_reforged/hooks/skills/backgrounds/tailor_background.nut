::Reforged.HooksMod.hook("scripts/skills/backgrounds/tailor_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 1.2,
			"pg.rf_fast": 1.2,
			"pg.rf_large": 0.8,
			"pg.rf_resilient": 0.8,
			"pg.rf_sturdy": 0.75,
			"pg.rf_talented": 3
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
