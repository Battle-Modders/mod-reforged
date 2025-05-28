::Reforged.HooksMod.hook("scripts/skills/traits/tough_trait", function(q) {
	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_tough":
				return -1;
		}
	}}.getPerkGroupMultiplier;
});
