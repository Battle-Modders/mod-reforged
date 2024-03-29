::Reforged.HooksMod.hook("scripts/skills/backgrounds/sellsword_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 1.5,
			"pg.rf_leadership": 2,
			"pg.rf_tactician": 3,
			"pg.rf_talented": 3,
			"pg.rf_vicious": 2,
			"pg.rf_spear": 0.75,
			"pg.rf_sword": 0.8,
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
	                ::MSU.Class.WeightedContainer([
	                    [50, "pg.rf_soldier"],
	                    [30, "pg.rf_raider"],
	                    [20, "DynamicPerks_NoPerkGroup"]
	                ]),
	                ::MSU.Class.WeightedContainer([
	                    [10, "pg.special.rf_professional"],
	                    [90, "DynamicPerks_NoPerkGroup"]
	                ])
				],
				"pgc.rf_shared_1": [
					"pg.rf_trained"
				],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
