::Reforged.HooksMod.hook("scripts/skills/traits/short_sighted_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_marksmanship":
				return 0;
		}
	}
});
