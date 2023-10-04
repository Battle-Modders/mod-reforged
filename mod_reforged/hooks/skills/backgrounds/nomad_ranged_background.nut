::Reforged.HooksMod.hook("scripts/skills/backgrounds/nomad_ranged_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_tactician": 3,
			"pg.rf_talented": 2,
			"pg.rf_trained": 1.4,
			"pg.rf_unstoppable": 1.5,
			"pg.rf_vicious": 1.5,
			"pg.rf_bow": 3,
			"pg.rf_crossbow": 2,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
			"pg.rf_throwing": 1.5
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_raider"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_light_armor",
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_ranged"
				]
			}
		});
	}
});
