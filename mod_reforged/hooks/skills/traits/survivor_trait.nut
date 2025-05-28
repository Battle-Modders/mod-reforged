::Reforged.HooksMod.hook("scripts/skills/traits/survivor_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_vigorous":
				return -1;
		}
	}}.getPerkGroupMultiplier;
});
