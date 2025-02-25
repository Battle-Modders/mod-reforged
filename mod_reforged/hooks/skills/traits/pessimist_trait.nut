::Reforged.HooksMod.hook("scripts/skills/traits/pessimist_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_unstoppable":
				return 0.5;
		}
	}
});
