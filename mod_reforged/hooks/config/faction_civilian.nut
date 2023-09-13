// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.Swordmaster, {
	Hitpoints = 80,
	Stamina = 150,
	MeleeDefense = 50,
	RangedDefense = 20,
	Initiative = 150,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.HedgeKnight, {
	Stamina = 215,
	MeleeSkill = 90,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.MasterArcher, {
	Stamina = 150,
	RangedSkill = 90,
	RangedDefense = 30,
	Initiative = 150,
	FatigueRecoveryRate = 15
});
