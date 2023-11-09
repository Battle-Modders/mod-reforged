::Reforged.HooksMod.hook("scripts/skills/backgrounds/slave_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_agile": 0.75,
			"pg.rf_fast": 0.75,
			"pg.rf_large": 0.25,
			"pg.rf_leadership": 0.5,
			"pg.rf_resilient": 0.25,
			"pg.rf_talented": 0
		};
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_pauper"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.onAdded = @(__original) function()
	{
		__original();

		if (::World.Assets.getOrigin().getID() == "scenario.manhunters")
		{
			this.getContainer().getActor().m.ParagonLevel = 7;
		}
	}
});
