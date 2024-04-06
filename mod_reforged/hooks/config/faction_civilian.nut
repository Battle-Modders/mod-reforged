// Adjust Vanilla Actors
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
