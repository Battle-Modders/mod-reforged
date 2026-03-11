// Adjust Vanilla Actors
::Reforged.Entities.editEntity("BarbarianThrall",
	null,
	{
		XP = 175,
		ActionPoints = 9,
		Hitpoints = 70,
		Bravery = 70,
		Stamina = 120,
		MeleeSkill = 55,
		RangedSkill = 50,
		MeleeDefense = 0,
		RangedDefense = 10, // vanilla 0
		Initiative = 115,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.editEntity("BarbarianMarauder", // Barbarian Reaver
	null,
	{
		XP = 250,
		ActionPoints = 9,
		Hitpoints = 120,
		Bravery = 80,
		Stamina = 130,
		MeleeSkill = 65,
		RangedSkill = 60,
		MeleeDefense = 10,
		RangedDefense = 10,
		Initiative = 115,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15 // vanilla 20
	}
);
::Reforged.Entities.editEntity("BarbarianChampion", // Barbarian Chosen
	null,
	{
		XP = 350,
		ActionPoints = 9,
		Hitpoints = 130,
		Bravery = 90,
		Stamina = 140,
		MeleeSkill = 75,
		RangedSkill = 60,
		MeleeDefense = 15,
		RangedDefense = 0, // vanilla 10
		Initiative = 115,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15 // vanilla 20
	}
);
::Reforged.Entities.editEntity("BarbarianChosen", // Barbarian King
	null,
	{
		XP = 625, // vanilla 500
		ActionPoints = 9,
		Hitpoints = 200, // vanilla 150
		Bravery = 110,
		Stamina = 200, // vanilla 150
		MeleeSkill = 90, // vanilla 80
		RangedSkill = 65,
		MeleeDefense = 25, // vanilla 15
		RangedDefense = 15, // vanilla 10
		Initiative = 130, // vanilla 115
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15 // vanilla 25
	}
);
::Reforged.Entities.editEntity("BarbarianMadman",
	null,
	{
		XP = 500,
		ActionPoints = 9,
		Hitpoints = 160,
		Bravery = 100,
		Stamina = 200,
		MeleeSkill = 80,
		RangedSkill = 0,
		MeleeDefense = 10,
		RangedDefense = 10,
		Initiative = 115,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15 // vanilla 25
	}
);
