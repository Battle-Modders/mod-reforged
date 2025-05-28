::Reforged.HooksMod.hook("scripts/skills/backgrounds/brawler_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
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
	}}.createPerkTreeBlueprint;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		if (::Reforged.Skills.getPerkGroupMultiplier_MeleeOnly(_groupID, _perkTree) == 0)
			return 0;

		switch (_groupID)
		{
			case "pg.special.rf_leadership":
				return 3;

			case "pg.rf_unstoppable":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
