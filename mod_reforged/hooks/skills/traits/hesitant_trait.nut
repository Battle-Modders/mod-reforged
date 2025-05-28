::Reforged.HooksMod.hook("scripts/skills/traits/hesitant_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_fast":
				return 0;
		}
	}}.getPerkGroupMultiplier;
});
