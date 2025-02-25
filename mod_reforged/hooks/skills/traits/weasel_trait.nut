::Reforged.HooksMod.hook("scripts/skills/traits/weasel_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
				return -1;
		}
	}
});
