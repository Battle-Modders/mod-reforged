//Ancient Dead
::Const.World.Spawn.Troops.SkeletonLight.Strength = 15;
::Const.World.Spawn.Troops.SkeletonLight.Cost = 15;
::Const.World.Spawn.Troops.SkeletonMedium.Strength = 30;
::Const.World.Spawn.Troops.SkeletonMedium.Cost = 30;
::Const.World.Spawn.Troops.SkeletonMediumPolearm.Strength = 30;
::Const.World.Spawn.Troops.SkeletonMediumPolearm.Cost = 30;
::Const.World.Spawn.Troops.SkeletonHeavy.Strength = 50;
::Const.World.Spawn.Troops.SkeletonHeavy.Cost = 50;

//Bandits
::Const.World.Spawn.Troops.Wardog.Strength = 6;
::Const.World.Spawn.Troops.Wardog.Cost = 6;
::Const.World.Spawn.Troops.ArmoredWardog.Strength = 8;
::Const.World.Spawn.Troops.ArmoredWardog.Cost = 8;
::Const.World.Spawn.Troops.BanditThug.Strength = 12;
::Const.World.Spawn.Troops.BanditThug.Cost = 12;
::Const.World.Spawn.Troops.BanditMarksmanLOW.Strength = 12;
::Const.World.Spawn.Troops.BanditMarksmanLOW.Cost = 12;
::Const.World.Spawn.Troops.BanditMarksman.Strength = 30;
::Const.World.Spawn.Troops.BanditMarksman.Cost = 30;
::Const.World.Spawn.Troops.BanditRaiderWolf.Strength = 30;
::Const.World.Spawn.Troops.BanditRaiderWolf.Cost = 30;
::Const.World.Spawn.Troops.BanditRaider.Strength = 30;
::Const.World.Spawn.Troops.BanditRaider.Cost = 30;
::Const.World.Spawn.Troops.BanditLeader.Strength = 40;
::Const.World.Spawn.Troops.BanditLeader.Cost = 40;

//Civilian
::Const.World.Spawn.Troops.HedgeKnight.Strength = 45;
::Const.World.Spawn.Troops.HedgeKnight.Cost = 45;
::Const.World.Spawn.Troops.MasterArcher.Strength = 45;
::Const.World.Spawn.Troops.MasterArcher.Cost = 45;
::Const.World.Spawn.Troops.Swordmaster.Strength = 45;
::Const.World.Spawn.Troops.Swordmaster.Cost = 45;

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
		Strength = 18,
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
		Strength = 24,
		Cost = 24,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_vandal"
	},
	RF_BanditPillager = {
		ID = ::Const.EntityType.RF_BanditPillager,
		Variant = 0,
		Strength = 24,
		Cost = 24,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_pillager"
	},
	RF_BanditOutlaw = {
		ID = ::Const.EntityType.RF_BanditOutlaw,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_outlaw"
	},
	RF_BanditBandit = {
		ID = ::Const.EntityType.RF_BanditBandit,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_bandit"
	},
	RF_BanditHighwayman = {
		ID = ::Const.EntityType.RF_BanditHighwayman,
		Variant = 0,
		Strength = 36,
		Cost = 36,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_highwayman"
	},
	RF_BanditMarauder = {
		ID = ::Const.EntityType.RF_BanditMarauder,
		Variant = 0,
		Strength = 36,
		Cost = 36,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_marauder"
	},
	RF_BanditSharpshooter = {
		ID = ::Const.EntityType.RF_BanditSharpshooter,
		Variant = 0,
		Strength = 36,
		Cost = 36,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_bandit_sharpshooter"
	},
	RF_BanditKiller = {
		ID = ::Const.EntityType.RF_BanditKiller,
		Variant = 0,
		Strength = 36,
		Cost = 36,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_bandit_killer"
	},
	RF_BanditBaron = {
		ID = ::Const.EntityType.RF_BanditBaron,
		Variant = 1,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_bandit_baron"
	},

	// Ancient Dead
	RF_SkeletonLightElite = {
		ID = ::Const.EntityType.RF_SkeletonLightElite,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_light_elite"
	},
	RF_SkeletonLightElitePolearm = {
		ID = ::Const.EntityType.RF_SkeletonLightElite,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_light_elite_polearm"
	},
	RF_SkeletonMediumElite = {
		ID = ::Const.EntityType.RF_SkeletonMediumElite,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_medium_elite"
	},
	RF_SkeletonMediumElitePolearm = {
		ID = ::Const.EntityType.RF_SkeletonMediumElite,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
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
		Row = 1,
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
});
