::Reforged.HooksMod.hook("scripts/skills/backgrounds/poacher_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.RangedBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_light_armor"
				],
				"pgc.rf_fighting_style": []
			}
		});
	}
});
