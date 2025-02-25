::Reforged.HooksMod.hook("scripts/skills/backgrounds/assassin_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_knave"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [
					"pg.rf_medium_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
					"pg.rf_swift"
				]
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
			case "pg.rf_agile":
			case "pg.rf_fast":
				return 4;

			case "pg.special.rf_leadership":
				return 0;

			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 0.66;

			case "pg.rf_unstoppable":
			case "pg.rf_vicious":
				return 3;

			case "pg.rf_hammer":
				return 0.5;

			case "pg.rf_mace":
				return 0.75;
		}
	}
});
