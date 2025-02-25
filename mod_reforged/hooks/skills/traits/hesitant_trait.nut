::Reforged.HooksMod.hook("scripts/skills/traits/hesitant_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_fast":
				return 0;
		}
	}
});
