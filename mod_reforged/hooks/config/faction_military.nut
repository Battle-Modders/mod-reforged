// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.Footman, {
	XP = 300,
	RangedDefense = 0
});
::MSU.Table.merge(::Const.Tactical.Actor.Billman, {
	XP = 300,
	Stamina = 100,
	MeleeSkill = 75,
	Initiative = 100
});
::MSU.Table.merge(::Const.Tactical.Actor.Arbalester, {
	XP = 300,
	RangedSkill = 70,
	RangedDefense = 10
});
::MSU.Table.merge(::Const.Tactical.Actor.Greatsword, {
	XP = 475,
	Stamina = 115,
	MeleeSkill = 85,
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Sergeant, {
	XP = 400,
	Hitpoints = 120,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.StandardBearer, {
	XP = 300,
	Stamina = 115,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Knight, {
	XP = 600,
	Bravery = 100,
	Stamina = 150,
	Initiative = 110,
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Noble, {
	FatigueRecoveryRate = 15
});

// New Reforged Actors
::Const.Tactical.Actor.RF_FootmanHeavy <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 70,
	Stamina = 130,
	MeleeSkill = 75,
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
::Const.Tactical.Actor.RF_BillmanHeavy <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 80,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_ArbalesterHeavy <- {
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
	XP = 450,
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
	MeleeSkill = 90,
	RangedSkill = 60,
	MeleeDefense = 25,
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
::Const.Tactical.Actor.RF_HeraldsBodyguard <- {
	XP = 500,
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
