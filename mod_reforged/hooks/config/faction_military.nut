// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.Footman, {
	XP = 300, // vanilla 250
	ActionPoints = 9,
	Hitpoints = 75, // vanilla 70
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 75, // vanilla 70
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 0, // vanilla 5
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Billman, {
	XP = 300, // vanilla 250
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 100, // vanilla 120
	MeleeSkill = 75, // vanilla 70
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 10, // vanilla 5
	Initiative = 100, // vanilla 80
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Arbalester, { // Crossbowman
	XP = 300, // vanilla 250
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 70, // vanilla 60
	MeleeDefense = 5,
	RangedDefense = 10, // vanilla 5
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Greatsword, { // Zweihander
	XP = 475, // vanilla 350
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 70,
	Stamina = 115, // vanilla 130
	MeleeSkill = 85, // vanilla 75
	RangedSkill = 50,
	MeleeDefense = 20,
	RangedDefense = 0, // vanilla 10
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});
::MSU.Table.merge(::Const.Tactical.Actor.Sergeant, {
	XP = 400, // vanilla 350
	ActionPoints = 9,
	Hitpoints = 120, // vanilla 100
	Bravery = 80,
	Stamina = 130,
	MeleeSkill = 80,
	RangedSkill = 60,
	MeleeDefense = 25,
	RangedDefense = 15,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});
::MSU.Table.merge(::Const.Tactical.Actor.StandardBearer, {
	XP = 300, // vanilla 250
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 90,
	Stamina = 115, // vanilla 130
	MeleeSkill = 65,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});
::MSU.Table.merge(::Const.Tactical.Actor.Knight, {
	XP = 600, // vanilla 450
	ActionPoints = 9,
	Hitpoints = 135,
	Bravery = 100, // vanilla 90
	Stamina = 150, // vanilla 140
	MeleeSkill = 95, // vanilla 90
	RangedSkill = 60,
	MeleeDefense = 25,
	RangedDefense = 5, // vanilla 10
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});
::MSU.Table.merge(::Const.Tactical.Actor.Noble, {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 75,
	Stamina = 125,
	MeleeSkill = 75,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});

// New Reforged Actors
::Const.Tactical.Actor.RF_FootmanHeavy <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 85,
	Bravery = 70,
	Stamina = 130,
	MeleeSkill = 80,
	RangedSkill = 50,
	MeleeDefense = 15,
	RangedDefense = 0,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BillmanHeavy <- { // Halberdier
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 80,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 15,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_ArbalesterHeavy <- { // Arbalester
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 110,
	MeleeSkill = 55,
	RangedSkill = 70,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_ManAtArms <- {
	XP = 475,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 85,
	RangedSkill = 50,
	MeleeDefense = 20,
	RangedDefense = 0,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_Fencer <- {
	XP = 475,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 85,
	RangedSkill = 50,
	MeleeDefense = 20,
	RangedDefense = 0,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_Herald <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 90,
	Stamina = 125,
	MeleeSkill = 75,
	RangedSkill = 50,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_Marshal <- {
	XP = 550,
	ActionPoints = 9,
	Hitpoints = 150,
	Bravery = 100,
	Stamina = 140,
	MeleeSkill = 90,
	RangedSkill = 60,
	MeleeDefense = 30,
	RangedDefense = 20,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_KnightAnointed <- {
	XP = 800,
	ActionPoints = 9,
	Hitpoints = 150,
	Bravery = 120,
	Stamina = 170,
	MeleeSkill = 100,
	RangedSkill = 60,
	MeleeDefense = 25,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_HeraldsBodyguard <- { // Royal Guard
	XP = 550,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 90,
	Stamina = 140,
	MeleeSkill = 90,
	RangedSkill = 60,
	MeleeDefense = 20,
	RangedDefense = 0,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_Squire <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
