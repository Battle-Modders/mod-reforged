::Reforged.HooksMod.hook("scripts/skills/backgrounds/monk_turned_flagellant_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_heavy_armor":
			case "pg.rf_shield":
			case "pg.rf_vicious":
				return 0;

			case "pg.special.rf_leadership":
				return 10;

			case "pg.rf_vigorous":
				return 3;

			case "pg.rf_power":
			case "pg.rf_swift":
				return 2;
		}
	}
});
