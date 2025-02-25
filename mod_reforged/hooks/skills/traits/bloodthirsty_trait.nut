::Reforged.HooksMod.hook("scripts/skills/traits/bloodthirsty_trait", function(q) {
	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_vicious":
				return -1;
		}
	}
});
