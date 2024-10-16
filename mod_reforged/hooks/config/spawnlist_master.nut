//Ancient Dead
::Const.World.Spawn.Troops.SkeletonLight.Strength = 15;  // Ancient Auxiliary - vanilla 14
::Const.World.Spawn.Troops.SkeletonLight.Cost = 12; // Ancient Auxiliary - vanilla 13
::Const.World.Spawn.Troops.SkeletonMedium.Strength = 28; // Ancient Legionary - vanilla 20
::Const.World.Spawn.Troops.SkeletonMedium.Cost = 28; // Ancient Legionary - vanilla 20
::Const.World.Spawn.Troops.SkeletonMediumPolearm.Strength = 28; // Ancient Legionary - vanilla 20
::Const.World.Spawn.Troops.SkeletonMediumPolearm.Cost = 28; // Ancient Legionary - vanilla 25
::Const.World.Spawn.Troops.SkeletonHeavy.Strength = 50; // Ancient Honor Guard - vanilla 30
::Const.World.Spawn.Troops.SkeletonHeavy.Cost = 50; // Ancient Honor Guard - vanilla 35

//Bandits
::Const.World.Spawn.Troops.Wardog.Strength = 6; // vanilla 9
::Const.World.Spawn.Troops.Wardog.Cost = 6; // vanilla 8
::Const.World.Spawn.Troops.ArmoredWardog.Strength = 8; // vanilla 9
::Const.World.Spawn.Troops.ArmoredWardog.Cost = 8; // vanilla 8
::Const.World.Spawn.Troops.BanditMarksman.Strength = 30; // vanilla 15
::Const.World.Spawn.Troops.BanditMarksman.Cost = 22; // vanilla 15
::Const.World.Spawn.Troops.BanditRaiderWolf.Strength = 30; // vanilla 25
::Const.World.Spawn.Troops.BanditRaiderWolf.Cost = 25; // vanilla 25
::Const.World.Spawn.Troops.BanditRaider.Strength = 28; // vanilla 20
::Const.World.Spawn.Troops.BanditRaider.Cost = 22; // vanilla 20
::Const.World.Spawn.Troops.BanditLeader.Strength = 40; // vanilla 30
::Const.World.Spawn.Troops.BanditLeader.Cost = 40; // vanilla 25

//Civilian
::Const.World.Spawn.Troops.HedgeKnight.Strength = 45; // vanilla 40
::Const.World.Spawn.Troops.HedgeKnight.Cost = 45; // vanilla 40
::Const.World.Spawn.Troops.MasterArcher.Strength = 45; // vanilla 40
::Const.World.Spawn.Troops.MasterArcher.Cost = 45; // vanilla 40
::Const.World.Spawn.Troops.Swordmaster.Strength = 45; // vanilla 40
::Const.World.Spawn.Troops.Swordmaster.Cost = 45; // vanilla 40

//Nobles
::Const.World.Spawn.Troops.Footman.Strength = 25; // vanilla 20
::Const.World.Spawn.Troops.Billman.Strength = 25; // vanilla 20
::Const.World.Spawn.Troops.Arbalester.Strength = 25; // Crossbowman - vanilla 20
::Const.World.Spawn.Troops.StandardBearer.Row = 3; // vanilla 2
::Const.World.Spawn.Troops.Sergeant.Strength = 40; // vanilla 30
::Const.World.Spawn.Troops.Sergeant.Cost = 30; // vanilla 25
::Const.World.Spawn.Troops.Greatsword.Strength = 35; // vanilla 30
::Const.World.Spawn.Troops.Greatsword.Variant = 1; // vanilla 0
::Const.World.Spawn.Troops.Greatsword.NameList <- ::Const.Strings.CharacterNames;
::Const.World.Spawn.Troops.Greatsword.TitleList <- ::Const.Strings.RF_ZweihanderTitles;
::Const.World.Spawn.Troops.Knight.Strength = 45; // vanilla 40

//Nomads
::Const.World.Spawn.Troops.NomadOutlaw.Cost = 20; // vanilla 25


// Cost is handled in bandit_units.nut
::MSU.Table.merge(::Const.World.Spawn.Troops, {
	// Bandits
	RF_BanditScoundrel = {
		ID = ::Const.EntityType.RF_BanditScoundrel,
		Variant = 0,
		Strength = 9,
		Cost = 9,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_scoundrel"
	},
	RF_BanditRobber = {
		ID = ::Const.EntityType.RF_BanditRobber,
		Variant = 0,
		Strength = 20,
		Cost = 18,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_robber"
	},
	RF_BanditHunter = {
		ID = ::Const.EntityType.RF_BanditHunter,
		Variant = 0,
		Strength = 18,
		Cost = 18,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_bandit_hunter"
	},
	RF_BanditVandal = {
		ID = ::Const.EntityType.RF_BanditVandal,
		Variant = 0,
		Strength = 20,
		Cost = 18,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_vandal"
	},
	RF_BanditPillager = {
		ID = ::Const.EntityType.RF_BanditPillager,
		Variant = 0,
		Strength = 20,
		Cost = 18,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_pillager"
	},
	RF_BanditOutlaw = {
		ID = ::Const.EntityType.RF_BanditOutlaw,
		Variant = 0,
		Strength = 28,
		Cost = 22,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_outlaw"
	},
	RF_BanditBandit = {
		ID = ::Const.EntityType.RF_BanditBandit,
		Variant = 0,
		Strength = 28,
		Cost = 22,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_bandit"
	},
	RF_BanditHighwayman = {
		ID = ::Const.EntityType.RF_BanditHighwayman,
		Variant = 0,
		Strength = 36,
		Cost = 26,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_highwayman"
	},
	RF_BanditMarauder = {
		ID = ::Const.EntityType.RF_BanditMarauder,
		Variant = 0,
		Strength = 36,
		Cost = 26,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_marauder"
	},
	RF_BanditSharpshooter = {
		ID = ::Const.EntityType.RF_BanditSharpshooter,
		Variant = 0,
		Strength = 36,
		Cost = 26,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_bandit_sharpshooter"
	},
	RF_BanditKiller = {
		ID = ::Const.EntityType.RF_BanditKiller,
		Variant = 0,
		Strength = 36,
		Cost = 26,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_killer"
	},
	RF_BanditBaron = {
		ID = ::Const.EntityType.RF_BanditBaron,
		Variant = 1,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_bandit_baron",
		NameList = ::Const.Strings.BanditLeaderNames,
		TitleList = null
	},

	// Ancient Dead
	RF_SkeletonLightElite = {
		ID = ::Const.EntityType.RF_SkeletonLightElite,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_light_elite"
	},
	RF_SkeletonLightElitePolearm = {
		ID = ::Const.EntityType.RF_SkeletonLightElite,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_light_elite_polearm"
	},
	RF_SkeletonMediumElite = {
		ID = ::Const.EntityType.RF_SkeletonMediumElite,
		Variant = 0,
		Strength = 36,
		Cost = 36,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_medium_elite"
	},
	RF_SkeletonMediumElitePolearm = {
		ID = ::Const.EntityType.RF_SkeletonMediumElite,
		Variant = 0,
		Strength = 36,
		Cost = 36,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_medium_elite_polearm"
	},
	RF_SkeletonHeavyLesser = {
		ID = ::Const.EntityType.RF_SkeletonHeavyLesser,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_heavy_lesser"
	},
	RF_SkeletonHeavyLesserBodyguard = {
		ID = ::Const.EntityType.RF_SkeletonHeavyLesser,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_heavy_lesser_bodyguard"
	},
	RF_VampireLord = {
		ID = ::Const.EntityType.RF_VampireLord,
		Variant = 1,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_vampire_lord",
		NameList = ::Const.Strings.RF_VampireLordNames,
		TitleList = ::Const.Strings.RF_VampireLordTitles
	},
	RF_SkeletonDecanus = {
		ID = ::Const.EntityType.RF_SkeletonDecanus,
		Variant = 0,
		Strength = 32,
		Cost = 32,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_decanus"
	},
	RF_SkeletonCenturion = {
		ID = ::Const.EntityType.RF_SkeletonCenturion,
		Variant = 0,
		Strength = 44,
		Cost = 44,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_centurion"
	},
	RF_SkeletonLegatus = {
		ID = ::Const.EntityType.RF_SkeletonLegatus,
		Variant = 1,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_legatus",
		NameList = ::Const.Strings.AncientDeadNames,
		TitleList = ::Const.Strings.RF_AncientDeadCommanderTitles
	},

	// Noble
	RF_FootmanHeavy = {
		ID = ::Const.EntityType.RF_FootmanHeavy,
		Variant = 0,
		Strength = 40,
		Cost = 30,
		Row = 0,
		Script = "scripts/entity/tactical/humans/rf_footman_heavy"
	},
	RF_BillmanHeavy = {
		ID = ::Const.EntityType.RF_BillmanHeavy,
		Variant = 0,
		Strength = 40,
		Cost = 30,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_billman_heavy"
	},
	RF_ArbalesterHeavy = {
		ID = ::Const.EntityType.RF_ArbalesterHeavy,
		Variant = 0,
		Strength = 40,
		Cost = 30,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_arbalester_heavy"
	},
	RF_ManAtArms = {
		ID = ::Const.EntityType.RF_ManAtArms,
		Variant = 1,
		Strength = 35,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_man_at_arms",
		NameList = ::Const.Strings.CharacterNames,
		TitleList = ::Const.Strings.RF_ManAtArmsTitles
	},
	RF_Fencer = {
		ID = ::Const.EntityType.RF_Fencer,
		Variant = 1,
		Strength = 35,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_fencer",
		NameList = ::Const.Strings.CharacterNames
		TitleList = ::Const.Strings.RF_FencerTitles
	},
	RF_Herald = {
		ID = ::Const.EntityType.RF_Herald,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_herald"
	},
	RF_Marshal = {
		ID = ::Const.EntityType.RF_Marshal,
		Variant = 0,
		Strength = 50,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/rf_marshal"
	},
	RF_KnightAnointed = {
		ID = ::Const.EntityType.RF_KnightAnointed,
		Variant = 2,
		Strength = 60,
		Cost = 45,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_knight_anointed"
		NameList = ::Const.Strings.RF_KnightAnointedNames,
		TitleList = null
	},
	RF_Squire = {
		ID = ::Const.EntityType.RF_Squire,
		Variant = 0,
		Strength = 25,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_squire"
	},
	RF_HeraldsBodyguard = {
		ID = ::Const.EntityType.RF_HeraldsBodyguard,
		Variant = 0,
		Strength = 40,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/humans/rf_heralds_bodyguard"
	}
});
