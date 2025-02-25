::Reforged.HooksMod.hook("scripts/skills/traits/fragile_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_tough":
				return 0;
		}
	}
});
