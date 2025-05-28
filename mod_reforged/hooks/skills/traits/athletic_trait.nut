::Reforged.HooksMod.hook("scripts/skills/traits/athletic_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
