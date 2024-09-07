// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.Wardog, {
	XP = 100, // vanilla 75
	ActionPoints = 12,
	Hitpoints = 50,
	Bravery = 50, // vanilla 40
	Stamina = 130,
	MeleeSkill = 55, // vanilla 50
	RangedSkill = 0,
	MeleeDefense = 25, // vanilla 20
	RangedDefense = 30, // vanilla 25
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditThug, { // reforged thug is a different design than vanilla thug
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 90, // vanilla 55
	Bravery = 50, // vanilla 40
	Stamina = 100, // vanilla 95
	MeleeSkill = 55,
	RangedSkill = 45,
	MeleeDefense = -5, // vanilla 0
	RangedDefense = 0,
	Initiative = 60, // vanilla 95
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditRaider, {
	XP = 275, // vanilla 250
	ActionPoints = 9,
	Hitpoints = 80, // vanilla 75
	Bravery = 60, // vanilla 55
	Stamina = 125,
	MeleeSkill = 72, // vanilla 65
	RangedSkill = 60, // vanilla 55
	MeleeDefense = 10,
	RangedDefense = 0, // vanilla 10
	Initiative = 110, // vanilla 115
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditMarksman, { // reforged marksman is a higher tier entity
	XP = 275, // vanilla 225
	ActionPoints = 9,
	Hitpoints = 65, // vanilla 60
	Bravery = 55, // vanilla 50
	Stamina = 115,
	MeleeSkill = 55, // vanilla 50
	RangedSkill = 70, // vanilla 60
	MeleeDefense = 5,
	RangedDefense = 15, // vanilla 10
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditLeader, {
	XP = 400, // vanilla 375
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 80, // vanilla 70
	Stamina = 130,
	MeleeSkill = 80, // vanilla 75
	RangedSkill = 45, // vanilla 65
	MeleeDefense = 20, // vanilla 15
	RangedDefense = 5, // vanilla 10
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15 // vanilla 20
});

// New Reforged Actors
::Const.Tactical.Actor.RF_BanditScoundrel <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 40,
	Stamina = 95,
	MeleeSkill = 55,
	RangedSkill = 45,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditVandal <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 50,
	Stamina = 115,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditPillager <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 110,
	Bravery = 60,
	Stamina = 115,
	MeleeSkill = 65,
	RangedSkill = 45,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 70,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditRobber <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 0,
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
::Const.Tactical.Actor.RF_BanditHunter <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 105,
	MeleeSkill = 50,
	RangedSkill = 60,
	MeleeDefense = 0,
	RangedDefense = 10,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditOutlaw <- {
	XP = 275,
	ActionPoints = 9,
	Hitpoints = 130,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 72,
	RangedSkill = 45,
	MeleeDefense = 5,
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditBandit <- {
	XP = 275,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 55,
	Stamina = 110,
	MeleeSkill = 72,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditHighwayman <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 85,
	Bravery = 70,
	Stamina = 130,
	MeleeSkill = 80,
	RangedSkill = 65,
	MeleeDefense = 15,
	RangedDefense = 0,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditMarauder <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 150,
	Bravery = 80,
	Stamina = 125,
	MeleeSkill = 80,
	RangedSkill = 45,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditKiller <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 80,
	RangedSkill = 70,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditSharpshooter <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 130,
	MeleeSkill = 65,
	RangedSkill = 80,
	MeleeDefense = 5,
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
::Const.Tactical.Actor.RF_BanditBaron <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 100,
	Stamina = 150,
	MeleeSkill = 90,
	RangedSkill = 45,
	MeleeDefense = 30,
	RangedDefense = 0,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
