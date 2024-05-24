// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.Direwolf, {
	XP = 250,
	MeleeSkill = 70,
	MeleeDefense = 15,
	RangedDefense = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.FrenziedDirewolf, {
	XP = 300,
	MeleeSkill = 75,
	MeleeDefense = 20,
	RangedDefense = 20
});
::MSU.Table.merge(::Const.Tactical.Actor.Hyena, {
	XP = 250,
	MeleeSkill = 70,
	MeleeDefense = 15,
	RangedDefense = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.FrenziedHyena, {
	XP = 300,
	MeleeSkill = 75,
	MeleeDefense = 20,
	RangedDefense = 20
});
::MSU.Table.merge(::Const.Tactical.Actor.Serpent, {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 110,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 15, // vanilla 10
	RangedDefense = 25,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Armor = [
		40,
		40
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.Spider, {
	XP = 100,
	ActionPoints = 11,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 130,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 15, // vanilla 10
	RangedDefense = 25, // vanilla 20
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
});
