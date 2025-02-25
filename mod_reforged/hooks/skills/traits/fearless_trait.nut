::Reforged.HooksMod.hook("scripts/skills/traits/fearless_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_unstoppable":
				return -1;

			case "pg.special.rf_leadership":
				return 5;
		}
	}
});
