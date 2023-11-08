// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonLight, {
	XP = 175
});
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonMedium, {
	XP = 300,
	Hitpoints = 65,
	Bravery = 100,
	MeleeSkill = 75,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 70
});
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonHeavy, {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 120,
	MeleeSkill = 90,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 80
});
::MSU.Table.merge(::Const.Tactical.Actor.SkeletonBoss, {
	XP = 1000
});


// New Reforged Actors
::Const.Tactical.Actor.RF_SkeletonDecanus <- {
	XP = 325,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 110,
	Stamina = 100,
	MeleeSkill = 80,
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
	Bravery = 120,
	Stamina = 100,
	MeleeSkill = 85,
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
	Bravery = 130,
	Stamina = 100,
	MeleeSkill = 90,
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
::Const.Tactical.Actor.RF_SkeletonLightElite <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 90,
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
::Const.Tactical.Actor.RF_SkeletonMediumElite <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 80,
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
::Const.Tactical.Actor.RF_SkeletonHeavyLesser <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 110,
	Stamina = 100,
	MeleeSkill = 80,
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

