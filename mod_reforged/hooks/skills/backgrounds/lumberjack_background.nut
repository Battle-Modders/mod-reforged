::Reforged.HooksMod.hook("scripts/skills/backgrounds/lumberjack_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 2,
			"pg.rf_leadership": 2,
			"pg.rf_resilient": 2,
			"pg.rf_sturdy": 2,
			"pg.rf_swift": 0.5
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_axe"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_power"
				]
			}
		});
	}
});
