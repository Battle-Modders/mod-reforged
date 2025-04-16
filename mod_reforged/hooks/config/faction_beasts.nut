// Adjust Vanilla Actors
::MSU.Table.merge(::Const.Tactical.Actor.Direwolf, {
	XP = 250, // vanilla 200
	ActionPoints = 12,
	Hitpoints = 130,
	Bravery = 50,
	Stamina = 180,
	MeleeSkill = 70, // vanilla 60
	RangedSkill = 0,
	MeleeDefense = 15, // vanilla 10
	RangedDefense = 15, // vanilla 10
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.FrenziedDirewolf, {
	XP = 300, // vanilla 250
	ActionPoints = 12,
	Hitpoints = 150,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 75, // vanilla 65
	RangedSkill = 0,
	MeleeDefense = 20, // vanilla 10
	RangedDefense = 20, // vanilla 10
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.Hyena, {
	XP = 250, // vanilla 200
	ActionPoints = 14,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 180,
	MeleeSkill = 70, // vanilla 60
	RangedSkill = 0,
	MeleeDefense = 15, // vanilla 10
	RangedDefense = 15, // vanilla 10
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.FrenziedHyena, {
	XP = 300, // vanilla 250
	ActionPoints = 14,
	Hitpoints = 140,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 75, // vanilla 65
	RangedSkill = 0,
	MeleeDefense = 20, // vanilla 10
	RangedDefense = 20, // vanilla 10
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.Lindwurm, {
	XP = 800,
	ActionPoints = 7,
	Hitpoints = 1100,
	Bravery = 180,
	Stamina = 400,
	MeleeSkill = 65, // vanilla 75 - lowered due to reach
	RangedSkill = 0,
	MeleeDefense = 5, // vanilla 10 - lowered due to reach
	RangedDefense = -10,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		400,
		200
	]
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
::MSU.Table.merge(::Const.Tactical.Actor.Unhold, {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 130,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 5, // vanilla 10 - lowered due to reach
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		0,
		0
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.UnholdBog, {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 130,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 5, // vanilla 10 - lowered due to reach
	RangedDefense = 15, // vanilla 5 - increased to offer variance compared to standard unhold
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		0,
		0
	]
});
::MSU.Table.merge(::Const.Tactical.Actor.UnholdFrost, {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 600,
	Bravery = 150,
	Stamina = 400,
	MeleeSkill = 70, // vanilla 75 - lowered due to reach
	RangedSkill = 0,
	MeleeDefense = 5, // vanilla 10 - lowered due to reach
	RangedDefense = 0,
	Initiative = 85,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		90,
		90
	]
});
