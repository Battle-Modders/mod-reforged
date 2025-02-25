::Reforged.HooksMod.hook("scripts/skills/traits/quick_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_fast":
				return -1;
		}
	}
});
