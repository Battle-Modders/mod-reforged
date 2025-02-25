::Reforged.HooksMod.hook("scripts/skills/traits/athletic_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
				return 2;
		}
	}
});
