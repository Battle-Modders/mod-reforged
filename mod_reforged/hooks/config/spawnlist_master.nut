::logInfo("spawnlist_master")

::Const.World.Spawn.Troops.Wardog.Strength = 6;
::Const.World.Spawn.Troops.Wardog.Cost = 6;
::Const.World.Spawn.Troops.BanditThug.Strength = 12;
::Const.World.Spawn.Troops.BanditThug.Cost = 12;
::Const.World.Spawn.Troops.BanditMarksmanLOW.Strength = 12;
::Const.World.Spawn.Troops.BanditMarksmanLOW.Cost = 12;
::Const.World.Spawn.Troops.BanditMarksman.Strength = 24;
::Const.World.Spawn.Troops.BanditMarksman.Cost = 24;
::Const.World.Spawn.Troops.BanditRaiderWolf.Strength = 30;
::Const.World.Spawn.Troops.BanditRaiderWolf.Cost = 30;
::Const.World.Spawn.Troops.BanditRaider.Strength = 30;
::Const.World.Spawn.Troops.BanditRaider.Cost = 30;
::Const.World.Spawn.Troops.BanditLeader.Strength = 40;
::Const.World.Spawn.Troops.BanditLeader.Cost = 40;
::Const.World.Spawn.Troops.HedgeKnight.Strength = 45;
::Const.World.Spawn.Troops.HedgeKnight.Cost = 45;
::Const.World.Spawn.Troops.MasterArcher.Strength = 45;
::Const.World.Spawn.Troops.MasterArcher.Cost = 45;
::Const.World.Spawn.Troops.Swordmaster.Strength = 45;
::Const.World.Spawn.Troops.Swordmaster.Cost = 45;

::DynamicSpawns.Units.findById("Bandit.Wardog").m.Cost = 6;
::DynamicSpawns.Units.findById("Bandit.Thug").m.Cost = 12;
::DynamicSpawns.Units.findById("Bandit.Poacher").m.Cost = 12;
::DynamicSpawns.Units.findById("Bandit.Marksman").m.Cost = 24;
::DynamicSpawns.Units.findById("Bandit.Raider").m.Cost = 30;
::DynamicSpawns.Units.findById("Bandit.Leader").m.Cost = 40;
::DynamicSpawns.Units.findById("Human.MasterArcher").m.Cost = 45;
::DynamicSpawns.Units.findById("Human.HedgeKnight").m.Cost = 45;
::DynamicSpawns.Units.findById("Human.Swordmaster").m.Cost = 45;

// Cost is handled in bandit_units.nut
::MSU.Table.merge(::Const.World.Spawn.Troops, {
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
		Strength = 24,
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
	}
});
