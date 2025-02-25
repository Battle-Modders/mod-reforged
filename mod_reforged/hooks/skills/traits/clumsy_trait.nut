::Reforged.HooksMod.hook("scripts/skills/traits/clumsy_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_trained":
			case "pg.special.rf_back_to_basics":
				return 0;
		}
	}
});
