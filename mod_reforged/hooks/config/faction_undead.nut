// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonLight, { // Ancient Auxiliary
	XP = 200, // vanilla 150
	ActionPoints = 9,
	Hitpoints = 50, // vanilla 45
	Bravery = 55, // vanilla 70
	Stamina = 100,
	MeleeSkill = 60, // vanilla 55
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonMedium, { // Ancient Legionary
	XP = 300, // vanilla 250
	ActionPoints = 9,
	Hitpoints = 65, // vanilla 55
	Bravery = 75, // vanilla 90
	Stamina = 100,
	MeleeSkill = 70, // vanilla 65
	RangedSkill = 0,
	MeleeDefense = 5, // vanilla 0
	RangedDefense = 5, // vanilla 0
	Initiative = 70, // vanilla 65
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonHeavy, { // Our Honor Guard is a higher tier unit than vanilla. The more proper comparison to vanilla Honor Guard is the SkeletonHeavyLesser (Ancient Praetorian).
	XP = 500, // vanilla 350
	ActionPoints = 9,
	Hitpoints = 90, // vanilla 65
	Bravery = 100, // vanilla 110
	Stamina = 100,
	MeleeSkill = 80, // vanilla 75
	RangedSkill = 0,
	MeleeDefense = 15, // vanilla 5
	RangedDefense = 0, // vanilla 5
	Initiative = 75, // vanilla 70
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonBoss, { // The Conqueror
	XP = 1000, // vanilla 600
	ActionPoints = 9,
	Hitpoints = 350,
	Bravery = 120,
	Stamina = 100,
	MeleeSkill = 90,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	],
	DamageTotalMult = 1.35
});

// New Reforged Actors
::Const.Tactical.Actor.RF_SkeletonDecanus <- {
	XP = 325,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 80,
	Stamina = 100,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 75,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.RF_SkeletonCenturion <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 90,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 80,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.RF_SkeletonLegatus <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 85,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 85,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.RF_SkeletonLightElite <- { // Ancient Miles
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 65,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.RF_SkeletonMediumElite <- { // Ancient Palatinus
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 85,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 80,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.RF_SkeletonHeavyLesser <- { // Ancient Praetorian
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 90,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::Const.Tactical.Actor.RF_VampireLord <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 300,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 95,
	RangedSkill = 0,
	MeleeDefense = 30,
	RangedDefense = 30,
	Initiative = 140,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
