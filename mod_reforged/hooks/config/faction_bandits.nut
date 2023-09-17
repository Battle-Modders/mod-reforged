// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.Wardog, {
	XP = 100,
	Bravery = 50,
	MeleeSkill = 55,
	MeleeDefense = 25,
	RangedDefense = 30
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditThug, {
	XP = 200,
	Hitpoints = 70,
	Bravery = 50,
	Stamina = 115,
	MeleeSkill = 60,
	MeleeDefense = 5,
	Initiative = 90,
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditRaider, {
	XP = 300,
	Hitpoints = 80,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 75,
	RangedSkill = 45,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditMarksman, {
	XP = 300,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 70,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.BanditLeader, {
	XP = 400,
	Stamina = 145,
	Bravery = 80,
	MeleeSkill = 80,
	MeleeDefense = 20,
	RangedDefense = 15,
	FatigueRecoveryRate = 15
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
::Const.Tactical.Actor.RF_BanditRobber <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 50,
	Stamina = 110,
	MeleeSkill = 60,
	RangedSkill = 50,
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
::Const.Tactical.Actor.RF_BanditHunter <- {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 50,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 60,
	MeleeDefense = 5,
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
::Const.Tactical.Actor.RF_BanditVandal <- {
	XP = 275,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 55,
	Stamina = 140,
	MeleeSkill = 70,
	RangedSkill = 45,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditPillager <- {
	XP = 275,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 60,
	Stamina = 145,
	MeleeSkill = 70,
	RangedSkill = 45,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::Const.Tactical.Actor.RF_BanditOutlaw <- {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 65,
	Stamina = 155,
	MeleeSkill = 75,
	RangedSkill = 45,
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
::Const.Tactical.Actor.RF_BanditBandit <- {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 55,
	MeleeDefense = 10,
	RangedDefense = 15,
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
	Hitpoints = 90,
	Bravery = 70,
	Stamina = 155,
	MeleeSkill = 80,
	RangedSkill = 45,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 120,
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
	Hitpoints = 100,
	Bravery = 80,
	Stamina = 165,
	MeleeSkill = 80,
	RangedSkill = 45,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 100,
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
	Hitpoints = 80,
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
::Const.Tactical.Actor.RF_BanditKiller <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 125,
	MeleeSkill = 80,
	RangedSkill = 60,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 130,
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
	Stamina = 165,
	MeleeSkill = 90,
	RangedSkill = 45,
	MeleeDefense = 30,
	RangedDefense = 25,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
