::Reforged.HooksMod.hook("scripts/skills/backgrounds/orc_slayer_background", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTree = ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_laborer"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_hammer"
				],
				"pgc.rf_armor": [
					"pg.rf_medium_armor",
					"pg.rf_heavy_armor"
				],
				"pgc.rf_fighting_style": [
					"pg.rf_power",
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

			case "pgc.rf_weapon":
				return _collection.getMin() + 3;
		}
	}

	q.getPerkGroupMultiplier = @() function( _groupID, _perkTree )
	{
		if (::Reforged.Skills.getPerkGroupMultiplier_MeleeOnly(_groupID, _perkTree) == 0)
			return 0;

		switch (_groupID)
		{
			case "pg.special.rf_professional":
				return -1;

			case "pg.special.rf_leadership":
			case "pg.rf_tactician":
			case "pg.rf_dagger":
			case "pg.rf_polearm":
			case "pg.rf_spear":
				return 0;

			case "pg.rf_agile":
			case "pg.rf_fast":
				return 0.5;

			case "pg.rf_tough":
			case "pg.rf_vigorous":
				return 2;

			case "pg.rf_sword":
				return 0.9;
		}
	}
});
