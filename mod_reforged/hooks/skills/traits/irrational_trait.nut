::Reforged.HooksMod.hook("scripts/skills/traits/irrational_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_back_to_basics":
				return 0;
		}
	}}.getPerkGroupMultiplier;
});
