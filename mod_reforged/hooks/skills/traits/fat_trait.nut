::Reforged.HooksMod.hook("scripts/skills/traits/fat_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
			case "pg.rf_fast":
				return 0;

			case "pg.rf_tough":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
