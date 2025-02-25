::Reforged.HooksMod.hook("scripts/skills/traits/cocky_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_shield":
				return 0;

			case "pg.rf_fast":
				return 1.5;

			case "pg.rf_trained":
				return 0.5;
		}
	}
});
