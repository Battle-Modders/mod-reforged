::MSU.Table.merge(::Const.Tactical.Actor.Conscript, {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 60, // vanilla 70
	RangedSkill = 50,
	MeleeDefense = 0, // vanilla 10
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
::MSU.Table.merge(::Const.Tactical.Actor.Gunner, {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 75,
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
});
::MSU.Table.merge(::Const.Tactical.Actor.Officer, {
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Gladiator, {
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Assassin, {
	FatigueRecoveryRate = 15 // Vanilla 20
});
::MSU.Table.merge(::Const.Tactical.Actor.NomadCutthroat, {
	XP = 175, // vanilla 150
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 50, // vanilla 55
	RangedSkill = 45,
	MeleeDefense = 0, // vanilla 5
	RangedDefense = 0, // vanilla 5
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.NomadArcher, {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 55,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 65,
	MeleeDefense = 5,
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
::MSU.Table.merge(::Const.Tactical.Actor.NomadOutlaw, {
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.NomadLeader, {
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.DesertDevil, {
	RangedDefense = 15,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.Executioner, {
	RangedDefense = 0,
	FatigueRecoveryRate = 15
});
::MSU.Table.merge(::Const.Tactical.Actor.DesertStalker, {
	FatigueRecoveryRate = 15
});
