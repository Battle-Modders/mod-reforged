::Reforged.HooksMod.hook("scripts/skills/traits/ailing_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_vigorous":
				return 0;
		}
	}
});
