::Reforged.HooksMod.hook("scripts/skills/traits/brave_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
				return 2;
		}
	}
});
