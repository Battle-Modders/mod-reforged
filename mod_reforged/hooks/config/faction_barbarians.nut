// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.BarbarianThrall, {
	XP = 200, // vanilla 175
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
});
::MSU.Table.merge(::Const.Tactical.Actor.BarbarianMarauder, { // Barbarian Reaver
	XP = 275, // vanilla 250
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
});
::MSU.Table.merge(::Const.Tactical.Actor.BarbarianChampion, { // Barbarian Chosen
	XP = 425, // vanilla 350
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


	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.BarbarianChosen, { // Barbarian King
	XP = 600, //vanilla 500
	ActionPoints = 9,
	Hitpoints = 200, // vanilla 150
	Bravery = 110,
	Stamina = 150,
	MeleeSkill = 90, // vanilla 80
	RangedSkill = 65,
	MeleeDefense = 25, // vanilla 15
	RangedDefense = 15, // vanilla 10
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 25
});
::MSU.Table.merge(::Const.Tactical.Actor.BarbarianMadman, {
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
});
