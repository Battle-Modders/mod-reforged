::Reforged.HooksMod.hook("scripts/skills/traits/craven_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_unstoppable":
				return 0;
		}
	}}.getPerkGroupMultiplier;
});
