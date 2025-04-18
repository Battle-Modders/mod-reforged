this.rf_old_swordmaster_background <- ::inherit("scripts/skills/backgrounds/swordmaster_background", {
	m = {},
	function create()
	{
		this.swordmaster_background.create();
		this.m.ID = "background.rf_old_swordmaster";
		this.m.Name = "Old Swordmaster";
		this.m.Icon = "ui/backgrounds/rf_old_swordmaster_background.png";
		this.m.ExcludedTalents = [
			::Const.Attributes.RangedSkill,
			::Const.Attributes.RangedDefense
		];
		this.m.Excluded.extend([
			"trait.fat",
			"trait.survivor",
			"trait.greedy",
			"trait.loyal",
			"trait.disloyal"
		]);
		this.m.BeardChance = 100;
		this.m.Level = 3;
	}

	function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": [
					"pg.rf_soldier",
					"pg.rf_swordmaster"
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [
					"pg.rf_sword"
				],
				"pgc.rf_armor": [
					"pg.rf_light_armor"
				],
				"pgc.rf_fighting_style": []
			}
		});
	}

	function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_shared":
				return _collection.getMin() + 1;

			case "pgc.rf_weapon":
				return 1; // We only want this background to have the Sword perk group

			case "pgc.rf_armor":
				return 1; // We only want this background to have the Light Armor perk group

			case "pgc.rf_fighting_style":
				return _collection.getMin() + 1;
		}
	}

	function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.special.rf_leadership":
			case "pg.special.rf_fencer":
				return -1;

			case "pg.rf_agile":
			case "pg.rf_fast":
			case "pg.rf_tactician":
			case "pg.rf_ranged":
				return 0;
		}
	}
});

