::Reforged.HooksMod.hook("scripts/skills/traits/asthmatic_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_vigorous":
			case "pg.special.rf_man_of_steel":
				return 0;
		}
	}}.getPerkGroupMultiplier;
});
