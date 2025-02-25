::Reforged.HooksMod.hook("scripts/skills/backgrounds/pimp_background", function(q) {
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
			case "pgc.rf_shared_1":
				return _collection.getMin() + 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
			case "pg.rf_fast":
				return 1.2;

			case "pg.special.rf_leadership":
				return 2;

			case "pg.rf_trained":
			case "pg.rf_unstoppable":
			case "pg.rf_vicious":
				return 0.75;
		}
	}
});
