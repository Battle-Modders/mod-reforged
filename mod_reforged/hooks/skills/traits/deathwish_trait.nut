::Reforged.HooksMod.hook("scripts/skills/traits/deathwish_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_unstoppable":
				return -1;
		}
	}
});
