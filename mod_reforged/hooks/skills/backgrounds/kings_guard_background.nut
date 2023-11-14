::Reforged.HooksMod.hook("scripts/skills/backgrounds/kings_guard_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_throwing": 0,

			"pg.special.rf_professional": -1
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier"
				],
				"pgc.rf_shared_1": [
					"pg.rf_resilient",
					"pg.rf_unstoppable",
					"pg.rf_vicious"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_medium_armor",
					"pg.rf_heavy_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_shield",
					"pg.rf_swift"
				]
			}
		});
	}
});
