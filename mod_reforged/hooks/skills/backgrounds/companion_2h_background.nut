::Reforged.HooksMod.hook("scripts/skills/backgrounds/companion_2h_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.75,
			"pg.rf_fast": 0.75,
			"pg.special.rf_leadership": 0,
			"pg.rf_tactician": 0,
			"pg.rf_vicious": 1.5,
			"pg.rf_dagger": 0,
			"pg.rf_spear": 0,
			"pg.rf_sword": 0.9,
			"pg.rf_heavy_armor": 3
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeOnly);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
	                ::MSU.Class.WeightedContainer([
	                    [40, "pg.rf_laborer"],
	                    [30, "pg.rf_raider"],
	                    [30, "DynamicPerks_NoPerkGroup"]
	                ])
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_power"
				]
			}
		});
	}
});
