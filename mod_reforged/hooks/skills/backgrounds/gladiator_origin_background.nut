::Reforged.HooksMod.hook("scripts/skills/backgrounds/gladiator_origin_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0,
			"pg.rf_trained": 3,
			"pg.rf_unstoppable": 2,
			"pg.rf_bow": 0,
			"pg.rf_crossbow": 0,

			"pg.special.rf_professional": -1
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeSpecialist);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_trapper",
	                ::MSU.Class.WeightedContainer([
	                    [20, "pg.rf_laborer"],
	                    [30, "pg.rf_raider"],
	                    [50, "pg.rf_soldier"]
	                ])
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
