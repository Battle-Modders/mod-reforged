::Reforged.HooksMod.hook("scripts/skills/traits/determined_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_unstoppable":
				return -1;
		}
	}}.getPerkGroupMultiplier;
});
