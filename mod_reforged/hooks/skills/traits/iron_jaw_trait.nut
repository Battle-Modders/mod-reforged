::Reforged.HooksMod.hook("scripts/skills/traits/iron_jaw_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_vigorous":
				return 2;
		}
	}
});
