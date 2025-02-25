::Reforged.HooksMod.hook("scripts/skills/traits/drunkard_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_marksmanship":
				return 0;

			case "pg.special.rf_leadership":
				return 0.25;

			case "pg.rf_trained":
				return 0.5;
		}
	}
});
