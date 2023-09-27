::Reforged.HooksMod.hook("scripts/skills/backgrounds/miner_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_large": 2,
			"pg.rf_sturdy": 0.165,
			"pg.rf_talented": 0.5,
			"pg.rf_flail": 1.5,
			"pg.rf_mace": 1.5
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_hammer"
				],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
