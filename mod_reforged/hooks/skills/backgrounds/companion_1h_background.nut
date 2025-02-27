::Reforged.HooksMod.hook("scripts/skills/backgrounds/companion_1h_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[60, "pg.rf_militia"],
						[10, "pg.rf_soldier"],
						[30, "DynamicPerks_NoPerkGroup"]
					]).roll()
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_spear"
				],
				"pgc.rf_armor": [
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_shield"
				]
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
			case "pg.special.rf_leadership":
			case "pg.rf_bow":
			case "pg.rf_crossbow":
				return 0;

			case "pg.rf_ranged":
				return 0.33;
		}
	}
});
