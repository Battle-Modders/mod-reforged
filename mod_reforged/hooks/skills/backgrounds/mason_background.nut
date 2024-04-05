::Reforged.HooksMod.hook("scripts/skills/backgrounds/mason_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_flail": 1.5,
			"pg.rf_hammer": 2,
			"pg.rf_mace": 1.5,
			"pg.special.rf_student": 2
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
