::Reforged.HooksMod.hook("scripts/skills/backgrounds/hunter_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_bow",
					"pg.rf_crossbow",
					"pg.rf_throwing"
				],
				"pgc.rf_armor": [
					"pg.rf_light_armor",
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_ranged"
				]
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_weapon":
				return _collection.getMin() + 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_tactician":
			case "pg.rf_shield":
				return 0;

			case "pg.rf_agile":
			case "pg.rf_fast":
				return 1.5;
		}
	}
});
