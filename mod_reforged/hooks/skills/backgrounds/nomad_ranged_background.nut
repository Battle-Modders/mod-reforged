::Reforged.HooksMod.hook("scripts/skills/backgrounds/nomad_ranged_background", function(q) {
	q.createPerkTreeBlueprint = @() function()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[50, "pg.rf_knave"],
						[50, "pg.rf_raider"]
					]).roll()
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": function( _perkTree ) {
					local ret = [];
					local pgs = ::MSU.Class.WeightedContainer().addMany(1, ["pg.rf_bow", "pg.rf_crossbow", "pg.rf_throwing"]);
					ret.push(pgs.roll());
					pgs.remove(ret[0]);
					ret.push(pgs.roll());
					return ret;
				},
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
			case "pg.rf_tactician":
				return 3;

			case "pg.rf_trained":
				return 1.4;

			case "pg.rf_unstoppable":
			case "pg.rf_vicious":
				return 1.5;
		}
	}
});
