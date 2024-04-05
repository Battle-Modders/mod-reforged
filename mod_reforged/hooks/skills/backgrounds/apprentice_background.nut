::Reforged.HooksMod.hook("scripts/skills/backgrounds/apprentice_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
		};

		::MSU.Table.merge(this.m.PerkTreeMultipliers, ::Reforged.Skills.PerkTreeMultipliers.MeleeBackground);

		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pg.rf_exclusive_1": [],
				"pg.rf_shared_1": [],
				"pg.rf_weapon": [],
				"pg.rf_armor": [],
				"pg.rf_fighting_style": []
			}
		});
	}
});
