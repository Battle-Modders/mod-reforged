::Reforged.HooksMod.hook("scripts/skills/backgrounds/apprentice_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pg.rf_exclusive_1": [],
				"pg.rf_shared_1": [],
				"pg.rf_weapon": [],
				"pg.rf_armor": [],
				"pg.rf_fighting_style": []
			}
		});
	}

	q.getPerkGroupCollectionMin = @() function( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_fighting_style":
				return _collection.getMin() - 1;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_student":
				return -1;
		}
	}
});
