::Reforged.HooksMod.hook("scripts/skills/backgrounds/wildman_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_wildling"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": [
					"pg.rf_power"
				]
			}
		});
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		if (::Reforged.Skills.getPerkGroupMultiplier_MeleeOnly(_groupID) == 0)
			return 0;

		switch (_groupID)
		{
			case "pg.rf_agile":
				return 0.9;

			case "pg.rf_fast":
				return 0.8;

			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 3;
		}
	}
});
