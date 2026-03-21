::Reforged.Entities.editEntity("BanditThug",
	null, // Vanilla Cost 9
	{
		XP = 120, // vanilla 150
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
	}
);
::Reforged.Entities.addEntity(
	"RF_BanditPillager",
	"Brigand Pillager",
	"Brigand Pillagers",
	"rf_bandit_pillager_orientation",
	::Const.FactionType.Bandits,
	{
		Variant = 0,
		Strength = 16, // Vanilla RaiderLOW is 15
		Cost = 16, // Same as vanilla RaiderLOW
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_pillager"
	},
	{
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
	}
);
::Reforged.Entities.editEntity("BanditRaider",
	{
		Cost = 23, // vanilla 20
		Strength = 23 // vanilla 20
	},
	{
		XP = 250, // vanilla 250
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
	}
);
::Reforged.Entities.addEntity(
	"RF_BanditMarauder",
	"Brigand Marauder",
	"Brigand Marauder",
	"rf_bandit_marauder_orientation",
	::Const.FactionType.Bandits,
	{
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_marauder"
	},
	{
		XP = 300,
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
	}
);
::Reforged.Entities.addTroopAndActor(
	"RF_BanditThugTough",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.BanditThug, {
		Script = "scripts/entity/tactical/enemies/rf_bandit_thug_tough"
	}),
	{
		XP = 150,
		ActionPoints = 9,
		Hitpoints = 90,
		Bravery = 50,
		Stamina = 100,
		MeleeSkill = 55,
		RangedSkill = 45,
		MeleeDefense = -5,
		RangedDefense = 0,
		Initiative = 60,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.addTroopAndActor(
	"RF_BanditPillagerTough",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_BanditPillager, {
		Script = "scripts/entity/tactical/enemies/rf_bandit_pillager_tough"
	}),
	{
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
	}
);
::Reforged.Entities.addTroopAndActor(
	"RF_BanditRaiderTough",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.BanditRaider, {
		Script = "scripts/entity/tactical/enemies/rf_bandit_raider_tough"
	}),
	{
		XP = 250,
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
	}
);
::Reforged.Entities.addTroopAndActor(
	"RF_BanditMarauderTough",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_BanditMarauder, {
		Script = "scripts/entity/tactical/enemies/rf_bandit_marauder_tough"
	}),
	{
		XP = 300,
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
	}
);
::Reforged.Entities.addEntity(
	"RF_BanditVandal",
	"Brigand Vandal",
	"Brigand Vandals",
	"rf_bandit_vandal_orientation",
	::Const.FactionType.Bandits,
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_BanditPillager, { Script = "scripts/entity/tactical/enemies/rf_bandit_vandal" }),
	{
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
	}
);
::Reforged.Entities.addEntity(
	"RF_BanditOutlaw",
	"Brigand Outlaw",
	"Brigand Outlaws",
	"rf_bandit_outlaw_orientation",
	::Const.FactionType.Bandits,
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.BanditRaider, { Script = "scripts/entity/tactical/enemies/rf_bandit_outlaw" }),
	{
		XP = 250,
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
	}
);
::Reforged.Entities.addEntity(
	"RF_BanditHighwayman",
	"Brigand Highwayman",
	"Brigand Highwaymen",
	"rf_bandit_highwayman_orientation",
	::Const.FactionType.Bandits,
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_BanditMarauder, { Script = "scripts/entity/tactical/enemies/rf_bandit_highwayman" }),
	{
		XP = 300,
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
	}
);
::Reforged.Entities.editEntity("BanditPoacher",
	null, // Vanilla Cost/Strength: 12/12
	{
		XP = 150, // vanilla 175
		ActionPoints = 9,
		Hitpoints = 55,
		Bravery = 40,
		Stamina = 95,
		MeleeSkill = 50,
		RangedSkill = 50,
		MeleeDefense = 0,
		RangedDefense = 5,
		Initiative = 95,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.editEntity("BanditMarksman",
	{
		Cost = 19, // vanilla 15
		Strength = 19 // vanilla 15
	},
	{
		XP = 275, // vanilla 225
		ActionPoints = 9,
		Hitpoints = 65, // vanilla 60
		Bravery = 55, // vanilla 50
		Stamina = 105, // vanilla 115
		MeleeSkill = 50, // vanilla 50
		RangedSkill = 65, // vanilla 60
		MeleeDefense = 0,
		RangedDefense = 10, // vanilla 10
		Initiative = 110,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15 // vanilla 20
	},
	function()
	{
		::Const.EntityIcon[::Const.EntityType.BanditMarksman] = "rf_bandit_marksman_orientation";
	}
);
::Reforged.Entities.addEntity(
	"RF_BanditSharpshooter",
	"Brigand Sharpshooter",
	"Brigand Sharpshooters",
	"rf_bandit_sharpshooter_orientation",
	::Const.FactionType.Bandits,
	{
		Variant = 0,
		Strength = 26,
		Cost = 26,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_bandit_sharpshooter"
	},
	{
		XP = 275,
		ActionPoints = 9,
		Hitpoints = 65,
		Bravery = 55,
		Stamina = 115,
		MeleeSkill = 55,
		RangedSkill = 70,
		MeleeDefense = 5,
		RangedDefense = 15,
		Initiative = 115,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.editEntity("BanditLeader",
	{
		Cost = 30, // vanilla 25
		Strength = 40 // vanilla 30
	},
	{
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
	}
);
::Reforged.Entities.addEntity(
	"RF_BanditBaron",
	"Robber Baron",
	"Robber Barons",
	"rf_bandit_baron_orientation",
	::Const.FactionType.Bandits,
	{
		Variant = 1,
		Strength = 50,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_bandit_baron",
		NameList = ::Const.Strings.BanditLeaderNames,
		TitleList = null
	},
	{
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
	}
);
::Reforged.Entities.editEntity("Wardog",
	null, // Vanilla Cost/Strength: 8/9
	{
		XP = 75, // vanilla 75
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
	}
);
::Reforged.Entities.editEntity("Warhound",
	null, // Vanilla Cost/Strength: 10/10
	{
		XP = 100, // vanilla 100
		ActionPoints = 11, // vanilla 11,
		Hitpoints = 70, // vanilla 70,
		Bravery = 60, // vanilla 50,
		Stamina = 140, // vanilla 140,
		MeleeSkill = 60, // vanilla 55,
		RangedSkill = 0, // vanilla 0,
		MeleeDefense = 20, // vanilla 20,
		RangedDefense = 20, // vanilla 20,
		Initiative = 110, // vanilla 110,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.editEntity("BanditRaiderWolf",
	{
		Cost = 25, // vanilla 25
		Strength = 30 // vanilla 25
	}
);
