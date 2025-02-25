::Reforged.HooksMod.hook("scripts/skills/traits/dastard_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_unstoppable":
				return 0;
		}
	}
});
