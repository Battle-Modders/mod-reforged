::Reforged.HooksMod.hook("scripts/skills/backgrounds/slave_barbarian_background", function(q) {
	q.createPerkTreeBlueprint = @() { function createPerkTreeBlueprint()
	{
		return ::new(::DynamicPerks.Class.PerkTree).init({
			DynamicMap = {
				"pgc.rf_exclusive_1": @(_perkTree) [
					::MSU.Class.WeightedContainer([
						[20, "pg.rf_laborer"],
						[50, "pg.rf_raider"],
						[10, "pg.rf_trapper"],
						[20, "pg.rf_wildling"]
					]).roll()
				],
				"pgc.rf_shared_1": [],
				"pgc.rf_weapon": [],
				"pgc.rf_armor": [],
				"pgc.rf_fighting_style": []
			}
		});
	}}.createPerkTreeBlueprint;

	q.getPerkGroupCollectionMin = @() { function getPerkGroupCollectionMin( _collection )
	{
		switch (_collection.getID())
		{
			case "pgc.rf_armor":
				return _collection.getMin() - 1;
		}
	}}.getPerkGroupCollectionMin;

	q.getPerkGroupMultiplier = @() { function getPerkGroupMultiplier( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_agile":
			case "pg.rf_fast":
				return 0.75;

			case "pg.special.rf_leadership":
				return 0.25;

			case "pg.rf_vigorous":
				return 1.25;
		}
	}}.getPerkGroupMultiplier;

	q.onChangeAttributes = @() { function onChangeAttributes()
	{
		local c = {
            Hitpoints = [
                0,
                0
            ],
            Bravery = [
                -10,
                -5
            ],
            Stamina = [
                0,
                10
            ],
            MeleeSkill = [
                -10,
                10
            ],
            RangedSkill = [
                -15,
                15
            ],
            MeleeDefense = [
                -12,
                9
            ],
            RangedDefense = [
                -12,
                9
            ],
            Initiative = [
                -20,
                10
            ]
        };
        return c;
	}}.onChangeAttributes;
});
