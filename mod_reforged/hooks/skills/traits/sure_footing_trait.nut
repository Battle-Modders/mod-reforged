::Reforged.HooksMod.hook("scripts/skills/traits/sure_footing_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_trained":
				return 2;
		}
	}}.getPerkGroupMultiplier;
});
