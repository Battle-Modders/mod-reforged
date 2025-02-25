::Reforged.HooksMod.hook("scripts/skills/backgrounds/barbarian_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.BeardChance = 90;
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					::MSU.Class.WeightedContainer([
						[20, "pg.rf_laborer"],
						[50, "pg.rf_raider"],
						[10, "pg.rf_trapper"],
						[20, "pg.rf_wildling"]
					])
				],
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
			case "pgc.rf_weapon":
				return _collection.getMin() + 2;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.rf_tactician":
			case "pg.rf_trained":
			case "pg.rf_bow":
			case "pg.rf_crossbow":
			case "pg.rf_dagger":
			case "pg.rf_polearm":
			case "pg.rf_ranged":
				return 0;

			case "pg.rf_unstoppable":
				return 3;

			case "pg.rf_vicious":
				return 2;
		}
	}
});
