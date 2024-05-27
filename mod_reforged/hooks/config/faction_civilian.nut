// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.MilitiaVeteran, {
	XP = 200, // vanilla 150
	ActionPoints = 9,
	Hitpoints = 70, // vanilla 60
	Bravery = 70, // vanilla 50
	Stamina = 120, // vanilla 110
	MeleeSkill = 65, // vanilla 55
	RangedSkill = 50, // vanilla 40
	MeleeDefense = 10, // vanilla 5
	RangedDefense = 0,
	Initiative = 120, // vanilla 100
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.CaravanGuard, {
	RangedDefense = 0
});
::MSU.Table.merge(::Const.Tactical.Actor.BountyHunter, {
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Mercenary, {
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Oathbringer, {
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Swordmaster, {
	XP = 550,
	Hitpoints = 80,
	Stamina = 130,
	MeleeDefense = 60,
	RangedDefense = 20,
	Initiative = 130,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.HedgeKnight, {
	XP = 550,
	MeleeSkill = 90,
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.MasterArcher, {
	XP = 550,
	RangedSkill = 90,
	RangedDefense = 45,
	FatigueRecoveryRate = 15
});
