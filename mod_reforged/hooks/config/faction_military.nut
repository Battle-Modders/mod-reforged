::Reforged.Entities.editEntity("Footman",
	{
		Strength = 25 // vanilla 20
	},
	{
		XP = 250,
		ActionPoints = 9,
		Hitpoints = 75, // vanilla 70
		Bravery = 60,
		Stamina = 120,
		MeleeSkill = 75, // vanilla 70
		RangedSkill = 50,
		MeleeDefense = 10,
		RangedDefense = 5,
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
	"RF_FootmanHeavy",
	"Heavy Footman",
	"Heavy Footmen",
	"rf_footman_heavy_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 0,
		Strength = 40,
		Cost = 28,
		Row = 0,
		Script = "scripts/entity/tactical/humans/rf_footman_heavy"
	},
	{
		XP = 325,
		ActionPoints = 9,
		Hitpoints = 85,
		Bravery = 70,
		Stamina = 130,
		MeleeSkill = 80,
		RangedSkill = 50,
		MeleeDefense = 15,
		RangedDefense = 10,
		Initiative = 120,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.editEntity("Billman",
	{
		Strength = 25 // vanilla 20
	},
	{
		XP = 250, // vanilla 250
		ActionPoints = 9,
		Hitpoints = 70,
		Bravery = 60,
		Stamina = 100, // vanilla 120
		MeleeSkill = 75, // vanilla 70
		RangedSkill = 50,
		MeleeDefense = 10,
		RangedDefense = 10, // vanilla 5
		Initiative = 100, // vanilla 80
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
	"RF_BillmanHeavy", // Halberdier
	"Halberdier",
	"Halberdiers",
	"rf_billman_heavy_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 0,
		Strength = 40,
		Cost = 28,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_billman_heavy"
	},
	{
		XP = 325,
		ActionPoints = 9,
		Hitpoints = 80,
		Bravery = 70,
		Stamina = 120,
		MeleeSkill = 80,
		RangedSkill = 50,
		MeleeDefense = 10,
		RangedDefense = 15,
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
::Reforged.Entities.editEntity("Arbalester", // Crossbowman
	{
		Strength = 25 // vanilla 20
	},
	{
		XP = 250, // vanilla 250
		ActionPoints = 9,
		Hitpoints = 60,
		Bravery = 60,
		Stamina = 100,
		MeleeSkill = 55,
		RangedSkill = 70, // vanilla 60
		MeleeDefense = 5,
		RangedDefense = 10, // vanilla 5
		Initiative = 110,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	},
	function()
	{
		::Const.Strings.EntityName[::Const.EntityType.Arbalester] = "Crossbowman";
		::Const.Strings.EntityNamePlural[::Const.EntityType.Arbalester] = "Crossbowmen";
	}
);
::Reforged.Entities.addEntity(
	"RF_ArbalesterHeavy", // Arbalester
	"Arbalester",
	"Arbalesters",
	"rf_arbalester_heavy_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 0,
		Strength = 40,
		Cost = 28,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_arbalester_heavy"
	},
	{
		XP = 325,
		ActionPoints = 9,
		Hitpoints = 70,
		Bravery = 60,
		Stamina = 110,
		MeleeSkill = 55,
		RangedSkill = 70,
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
	}
);
::Reforged.Entities.addEntity(
	"RF_ManAtArms",
	"Man at Arms",
	"Men at Arms",
	"rf_man_at_arms_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 1,
		Strength = 35,
		Cost = 30,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_man_at_arms",
		NameList = ::Const.Strings.CharacterNames,
		TitleList = ::Const.Strings.RF_ManAtArmsTitles
	},
	{
		XP = 400,
		ActionPoints = 9,
		Hitpoints = 90,
		Bravery = 70,
		Stamina = 120,
		MeleeSkill = 85,
		RangedSkill = 50,
		MeleeDefense = 20,
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
::Reforged.Entities.editEntity("Greatsword", // Zweihander
	{
		Strength = 35, // vanilla 30
		Cost = 30, // vanilla 25: this is a stronger unit than vanilla
		Variant = 1, // vanilla 0
		NameList = ::Const.Strings.CharacterNames,
		TitleList = ::Const.Strings.RF_ZweihanderTitles
	},
	{
		XP = 400, // vanilla 350
		ActionPoints = 9,
		Hitpoints = 90,
		Bravery = 70,
		Stamina = 115, // vanilla 130
		MeleeSkill = 85, // vanilla 75
		RangedSkill = 50,
		MeleeDefense = 20,
		RangedDefense = 0, // vanilla 10
		Initiative = 115,
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
	"RF_Fencer",
	"Fencer",
	"Fencers",
	"rf_fencer_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 1,
		Strength = 35,
		Cost = 30,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_fencer",
		NameList = ::Const.Strings.CharacterNames
		TitleList = ::Const.Strings.RF_FencerTitles
	},
	{
		XP = 400,
		ActionPoints = 9,
		Hitpoints = 60,
		Bravery = 70,
		Stamina = 120,
		MeleeSkill = 85,
		RangedSkill = 50,
		MeleeDefense = 20,
		RangedDefense = 0,
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
::Reforged.Entities.editEntity("Knight",
	{
		Strength = 45 // vanilla 40
	},
	{
		XP = 450, // vanilla 450
		ActionPoints = 9,
		Hitpoints = 135,
		Bravery = 100, // vanilla 90
		Stamina = 150, // vanilla 140
		MeleeSkill = 95, // vanilla 90
		RangedSkill = 60,
		MeleeDefense = 25,
		RangedDefense = 5, // vanilla 10
		Initiative = 115,
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
	"RF_KnightAnointed",
	"Anointed Knight",
	"Anointed Knights",
	"rf_knight_anointed_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 2,
		Strength = 60,
		Cost = 45,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_knight_anointed"
		NameList = ::Const.Strings.RF_KnightAnointedNames,
		TitleList = null
	},
	{
		XP = 600,
		ActionPoints = 9,
		Hitpoints = 150,
		Bravery = 120,
		Stamina = 170,
		MeleeSkill = 100,
		RangedSkill = 60,
		MeleeDefense = 25,
		RangedDefense = 10,
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
	"RF_Squire",
	"Squire",
	"Squires",
	"rf_squire_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 0,
		Strength = 25,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_squire"
	},
	{
		XP = 275,
		ActionPoints = 9,
		Hitpoints = 80,
		Bravery = 60,
		Stamina = 120,
		MeleeSkill = 65,
		RangedSkill = 50,
		MeleeDefense = 10,
		RangedDefense = 0,
		Initiative = 120,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.editEntity("Sergeant",
	{
		Strength = 40 // vanilla 30
	},
	{
		XP = 350, // vanilla 350
		ActionPoints = 9,
		Hitpoints = 130, // vanilla 100
		Bravery = 80,
		Stamina = 130,
		MeleeSkill = 80,
		RangedSkill = 60,
		MeleeDefense = 25,
		RangedDefense = 15,
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
		::Const.EntityIcon[::Const.EntityType.Sergeant] = "rf_sergeant_orientation";
	}
);
::Reforged.Entities.addEntity(
	"RF_Marshal",
	"Marshal",
	"Marshals",
	"rf_marshal_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 0,
		Strength = 50,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_marshal"
	},
	{
		XP = 475,
		ActionPoints = 9,
		Hitpoints = 160,
		Bravery = 100,
		Stamina = 140,
		MeleeSkill = 90,
		RangedSkill = 60,
		MeleeDefense = 30,
		RangedDefense = 20,
		Initiative = 120,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15
	}
);
::Reforged.Entities.editEntity("StandardBearer",
	{
		Row = 3 // vanilla 2
	},
	{
		XP = 250, // vanilla 250
		ActionPoints = 9,
		Hitpoints = 80,
		Bravery = 90,
		Stamina = 115, // vanilla 130
		MeleeSkill = 65,
		RangedSkill = 50,
		MeleeDefense = 10,
		RangedDefense = 10,
		Initiative = 105,
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
		::Const.EntityIcon[::Const.EntityType.StandardBearer] = "rf_standard_bearer_orientation";
	}
);
::Reforged.Entities.addEntity(
	"RF_Herald",
	"Herald",
	"Heralds",
	"rf_herald_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_herald"
	},
	{
		XP = 350,
		ActionPoints = 9,
		Hitpoints = 80,
		Bravery = 90,
		Stamina = 125,
		MeleeSkill = 75,
		RangedSkill = 50,
		MeleeDefense = 15,
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
::Reforged.Entities.addEntity(
	"RF_HeraldsBodyguard", // Royal Guard
	"Herald\'s Bodyguard",
	"Herald\'s Bodyguards",
	"rf_heralds_bodyguard_orientation",
	::Const.FactionType.NobleHouse,
	{
		Variant = 0,
		Strength = 40,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_heralds_bodyguard"
	},
	{
		XP = 475,
		ActionPoints = 9,
		Hitpoints = 120,
		Bravery = 90,
		Stamina = 140,
		MeleeSkill = 90,
		RangedSkill = 60,
		MeleeDefense = 20,
		RangedDefense = 0,
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
::Reforged.Entities.editEntity("Noble",
	null,
	{
		XP = 300,
		ActionPoints = 9,
		Hitpoints = 75,
		Bravery = 75,
		Stamina = 125,
		MeleeSkill = 75,
		RangedSkill = 60,
		MeleeDefense = 10,
		RangedDefense = 10,
		Initiative = 120,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		],
		FatigueRecoveryRate = 15 // vanilla 20
	}
);
