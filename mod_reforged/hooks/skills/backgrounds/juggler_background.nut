::Reforged.HooksMod.hook("scripts/skills/backgrounds/juggler_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 3,
			"pg.rf_devious": 1.5,
			"pg.rf_fast": 3,
			"pg.rf_talented": 3,
			"pg.rf_flail": 3,
			"pg.rf_polearm": 1.5
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					::MSU.Class.WeightedContainer([
	                    [20, "pg.rf_trapper"],
	                    [80, "DynamicPerks_NoPerkGroup"]
	                ])
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_swift"
				]
			}
		});
	}
});
