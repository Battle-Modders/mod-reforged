::Reforged.HooksMod.hook("scripts/skills/traits/bright_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_discovered_talent":
			case "pg.special.rf_gifted":
			case "pg.special.rf_rising_star":
			case "pg.special.rf_student":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
