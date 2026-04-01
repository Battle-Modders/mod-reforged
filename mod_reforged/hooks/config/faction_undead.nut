// SkeletonLight unchanged
// SkeletonMedium unchanged
::Reforged.Entities.addEntity(
	"RF_SkeletonMediumElite",
	"Ancient Triarius",
	"Ancient Triarii",
	"rf_skeleton_medium_elite_orientation",
	::Const.FactionType.Undead,
	{
		Variant = 0,
		Strength = 35,
		Cost = 30,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_medium_elite"
	},
	{
		XP = 325,
		ActionPoints = 9,
		Hitpoints = 70,
		Bravery = 85,
		Stamina = 100,
		MeleeSkill = 75,
		RangedSkill = 0,
		MeleeDefense = 10,
		RangedDefense = 0,
		Initiative = 80,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_SkeletonMediumElitePolearm",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_SkeletonMediumElite, {
		Cost = 35, // follows vanilla trend of skeleton backline costing 5 more than frontline
		Row = 1
	})
);
::Reforged.Entities.editEntity("SkeletonHeavy",
	// Vanilla Honor Guard has been renamed to Praetorian as we have a higher tier unit
	// in Reforged called RF_SkeletonHeavyElite which is now called Honor Guard.
	{
		Strength = 35, // vanilla 30
		// Prevent vanilla SkeletonHeavy from becoming a champion.
		// We have a higher tier unit RF_SkeletonHeavyElite that can become champion instead.
		Variant = 0, // vanilla 1
		Row = 1 // vanilla 0
	},
	{
		XP = 350,
		ActionPoints = 9,
		Hitpoints = 75, // vanilla 65
		Bravery = 90,
		Stamina = 100,
		MeleeSkill = 75,
		RangedSkill = 0,
		MeleeDefense = 10, // vanilla 5
		RangedDefense = 0, // vanilla 5
		Initiative = 75,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	},
	function()
	{
		::Const.Strings.EntityName[::Const.EntityType.SkeletonHeavy] = "Ancient Praetorian";
		::Const.Strings.EntityNamePlural[::Const.EntityType.SkeletonHeavy] = "Ancient Praetorians";
		::Const.EntityIcon[::Const.EntityType.SkeletonHeavy] = "rf_skeleton_heavy_orientation";
	}
);
::Reforged.Entities.addEntity(
	"RF_SkeletonHeavyElite",
	"Ancient Honor Guard",
	"Ancient Honor Guards",
	"skeleton_03_orientation", // vanilla honor guard orientation icon
	::Const.FactionType.Undead,
	{
		Variant = 1,
		Strength = 45,
		Cost = 45,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_heavy_elite",
		NameList = ::Const.Strings.AncientDeadNames,
		TitleList = null
	},
	{
		XP = 450,
		ActionPoints = 9,
		Hitpoints = 90,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 80,
		RangedSkill = 0,
		MeleeDefense = 15,
		RangedDefense = 0,
		Initiative = 75,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_SkeletonHeavyEliteBodyguard",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_SkeletonHeavyElite, {
		Variant = 0,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_heavy_elite_bodyguard"
	})
);
::Reforged.Entities.addEntity(
	"RF_SkeletonDecanus",
	"Ancient Decanus",
	"Ancient Decani",
	"rf_skeleton_decanus_orientation",
	::Const.FactionType.Undead,
	{
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_decanus"
	},
	{
		XP = 325,
		ActionPoints = 9,
		Hitpoints = 65,
		Bravery = 80,
		Stamina = 100,
		MeleeSkill = 70,
		RangedSkill = 0,
		MeleeDefense = 10,
		RangedDefense = 10,
		Initiative = 75,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addEntity(
	"RF_SkeletonCenturion",
	"Ancient Centurion",
	"Ancient Centurions",
	"rf_skeleton_centurion_orientation",
	::Const.FactionType.Undead,
	{
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_centurion"
	},
	{
		XP = 400,
		ActionPoints = 9,
		Hitpoints = 75,
		Bravery = 90,
		Stamina = 100,
		MeleeSkill = 75,
		RangedSkill = 0,
		MeleeDefense = 15,
		RangedDefense = 15,
		Initiative = 80,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addEntity(
	"RF_SkeletonLegatus",
	"Ancient Legatus",
	"Ancient Legati",
	"rf_skeleton_legatus_orientation",
	::Const.FactionType.Undead,
	{
		Variant = 5,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_skeleton_legatus",
		NameList = ::Const.Strings.AncientDeadNames,
		TitleList = ::Const.Strings.RF_AncientDeadCommanderTitles
	},
	{
		XP = 500,
		ActionPoints = 9,
		Hitpoints = 85,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 80,
		RangedSkill = 0,
		MeleeDefense = 20,
		RangedDefense = 20,
		Initiative = 85,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addEntity(
	"RF_VampireLord",
	"Necrosavant Lord",
	"Necrosavant Lords",
	"rf_vampire_lord_orientation",
	::Const.FactionType.Undead,
	{
		Variant = 5,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_vampire_lord",
		NameList = ::Const.Strings.RF_VampireLordNames,
		TitleList = ::Const.Strings.RF_VampireLordTitles
	},
	{
		XP = 700,
		ActionPoints = 9,
		Hitpoints = 300,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 95,
		RangedSkill = 0,
		MeleeDefense = 30,
		RangedDefense = 30,
		Initiative = 140,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
// Draugr
::Reforged.Entities.addEntity(
	"RF_DraugrThrall",
	"Barrowkin Thrall",
	"Barrowkin Thralls",
	"rf_draugr_thrall_orientation",
	::Const.FactionType.RF_Draugr,
	{
		Variant = 0,
		Strength = 25,
		Cost = 18,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_draugr_thrall"
	},
	{
		XP = 200,
		ActionPoints = 9,
		Hitpoints = 120,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 65,
		RangedSkill = 0,
		MeleeDefense = 10,
		RangedDefense = 0,
		Initiative = 55,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_DraugrThrallBodyguard",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_DraugrThrall, {
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_draugr_thrall_bodyguard"
	})
);
::Reforged.Entities.addEntity(
	"RF_DraugrWarrior",
	"Barrowkin Drengr",
	"Barrowkin Drengr",
	"rf_draugr_warrior_orientation",
	::Const.FactionType.RF_Draugr,
	{
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/rf_draugr_warrior"
	},
	{
		XP = 350,
		ActionPoints = 9,
		Hitpoints = 160,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 75,
		RangedSkill = 0,
		MeleeDefense = 15,
		RangedDefense = 0,
		Initiative = 60,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_DraugrWarriorBodyguard",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_DraugrWarrior, {
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_draugr_warrior_bodyguard"
	})
);
::Reforged.Entities.addEntity(
	"RF_DraugrHuskarl",
	"Barrowkin Huskarl",
	"Barrowkin Huskarls",
	"rf_draugr_huskarl_orientation",
	::Const.FactionType.RF_Draugr,
	{
		Variant = 0,
		Strength = 45,
		Cost = 45,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/rf_draugr_huskarl"
	},
	{
		XP = 450,
		ActionPoints = 9,
		Hitpoints = 200,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 85,
		RangedSkill = 0,
		MeleeDefense = 25,
		RangedDefense = 0,
		Initiative = 65,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_DraugrHuskarlBodyguard",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_DraugrHuskarl, {
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_draugr_huskarl_bodyguard"
	})
);
::Reforged.Entities.addEntity(
	"RF_DraugrHero",
	"Barrowkin Hero",
	"Barrowkin Heroes",
	"rf_draugr_hero_orientation",
	::Const.FactionType.RF_Draugr,
	{
		Variant = 1,
		Strength = 60,
		Cost = 60,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_draugr_hero",
		NameList = ::Const.Strings.RF_DraugrNames,
		TitleList = ::Const.Strings.RF_DraugrTitles
	},
	{
		XP = 650,
		ActionPoints = 9,
		Hitpoints = 220,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 95,
		RangedSkill = 0,
		MeleeDefense = 35,
		RangedDefense = 0,
		Initiative = 70,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_DraugrHeroChampion",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_DraugrHero, {
		Variant = 999
	})
);
::Reforged.Entities.addEntity(
	"RF_DraugrShaman",
	"Barrow Seer",
	"Barrow Seers",
	"rf_draugr_shaman_orientation",
	::Const.FactionType.RF_Draugr,
	{
		Variant = 0,
		Strength = 60,
		Cost = 60,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_draugr_shaman"
	},
	{
		XP = 500,
		ActionPoints = 9,
		Hitpoints = 150,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 60,
		RangedSkill = 0,
		MeleeDefense = 10,
		RangedDefense = 20,
		Initiative = 75,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);

// ZOMBIES

::Reforged.Entities.editEntity("Necromancer",
	{
		// Increase the chance for Necromancers to be champions.
		Variant = 10
	}
);
// We have a higher tier unit RF_ZombieHero which is the new Fallen Hero
::Reforged.Entities.editEntity("ZombieKnight",
	{
		// Prevent vanilla ZombieKnight from becoming a champion.
		// We have a higher tier unit RF_ZombieHero that can become champion instead.
		Variant = 0
	},
	{
		XP = 250, // vanilla 250
		ActionPoints = 7, // vanilla 7
		Hitpoints = 180, // vanilla 180
		Bravery = 70, // vanilla 130
		Stamina = 100, // vanilla 100
		MeleeSkill = 60, // vanilla 60
		RangedSkill = 0, // vanilla 0
		MeleeDefense = 5, // vanilla 5
		RangedDefense = 0, // vanilla 0
		Initiative = 60, // vanilla 60
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	},
	function()
	{
		// ZombieKnight in Reforged is renamed to Fallen Knight and we have
		// a higher tier unit RF_ZombieHero which is now named Fallen Hero.
		::Const.Strings.EntityName[::Const.EntityType.ZombieKnight] = "Fallen Knight";
		::Const.Strings.EntityNamePlural[::Const.EntityType.ZombieKnight] = "Fallen Knights";
	}
);
::Reforged.Entities.addEntity(
	"RF_ZombieHero",
	"Fallen Hero",
	"Fallen Heroes",
	"zombie_03_orientation",
	::Const.FactionType.Zombies,
	{
		Variant = 1,
		Strength = 30,
		Cost = 32,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/rf_zombie_hero"
	},
	{
		XP = 350,
		ActionPoints = 7,
		Hitpoints = 230,
		Bravery = 110,
		Stamina = 100,
		MeleeSkill = 70,
		RangedSkill = 0,
		MeleeDefense = 10,
		RangedDefense = 0,
		Initiative = 70,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_ZombieHeroBodyguard",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_ZombieHero, {
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_zombie_hero_bodyguard"
	})
);
::Reforged.Entities.addEntity(
	"RF_Hollenhund",
	"Hollenhund",
	"Hollenhunds",
	"rf_hollenhund_orientation",
	::Const.FactionType.Zombies,
	{
		Variant = 0,
		Strength = 40,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_hollenhund"
	},
	{
		XP = 400,
		ActionPoints = 12,
		Hitpoints = 150,
		Bravery = 90,
		Stamina = 100,
		MeleeSkill = 80,
		RangedSkill = 0,
		MeleeDefense = 30,
		RangedDefense = 50,
		Initiative = 110,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addEntity(
	"RF_Banshee",
	"Klagmutter",
	"Klagmutters",
	"rf_banshee_orientation",
	::Const.FactionType.Zombies,
	{
		Variant = 10,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_banshee",
		NameList = ::Const.Strings.RF_BansheeNames,
		TitleList = ::Const.Strings.RF_BansheeTitles
	},
	{
		XP = 550,
		ActionPoints = 9,
		Hitpoints = 1,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 80,
		RangedSkill = 0,
		MeleeDefense = 30,
		RangedDefense = 999,
		Initiative = 100,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);

// Zombie Orc
::Reforged.Entities.addEntity(
	"RF_ZombieOrcYoung",
	"Wiederganger Orc Young",
	"Wiederganger Orc Young",
	"rf_zombie_orc_young_orientation",
	::Const.FactionType.Zombies,
	{
		Variant = 0,
		Strength = 14,
		Cost = 12,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/rf_zombie_orc_young"
	},
	{
		XP = 200,
		ActionPoints = 6,
		Hitpoints = 200,
		Bravery = 100,
		Stamina = 100,
		MeleeSkill = 50,
		RangedSkill = 0,
		MeleeDefense = -10,
		RangedDefense = -10,
		Initiative = 60,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_ZombieOrcYoungBodyguard",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_ZombieOrcYoung, {
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_zombie_orc_young_bodyguard"
	})
);
::Reforged.Entities.addEntity(
	"RF_ZombieOrcWarrior",
	"Wiederganger Orc Warrior",
	"Wiederganger Orc Warriors",
	"rf_zombie_orc_warrior_orientation",
	::Const.FactionType.Zombies,
	{
		Variant = 0,
		Strength = 28,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/rf_zombie_orc_warrior"
	},
	{
		XP = 350,
		ActionPoints = 7,
		Hitpoints = 300,
		Bravery = 90,
		Stamina = 100,
		MeleeSkill = 60,
		RangedSkill = 0,
		MeleeDefense = -15,
		RangedDefense = -15,
		Initiative = 60,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addTroop(
	"RF_ZombieOrcWarriorBodyguard",
	::MSU.Table.merge(clone ::Const.World.Spawn.Troops.RF_ZombieOrcWarrior, {
		Row = 2,
		Script = "scripts/entity/tactical/enemies/rf_zombie_orc_warrior_bodyguard"
	})
);
::Reforged.Entities.addEntity(
	"RF_ZombieOrcBerserker",
	"Wiederganger Orc Berserker",
	"Wiederganger Orc Berserkers",
	"rf_zombie_orc_berserker_orientation",
	::Const.FactionType.Zombies,
	{
		Variant = 0,
		Strength = 25,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/rf_zombie_orc_berserker"
	},
	{
		XP = 300,
		ActionPoints = 7,
		Hitpoints = 350,
		Bravery = 90,
		Stamina = 100,
		MeleeSkill = 60,
		RangedSkill = 0,
		MeleeDefense = 0,
		RangedDefense = -5,
		Initiative = 60,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);
::Reforged.Entities.addEntity(
	"RF_ZombieOrcWarlord",
	"Wiederganger Orc Warlord",
	"Wiederganger Orc Warlords",
	"rf_zombie_orc_warlord_orientation",
	::Const.FactionType.Zombies,
	{
		Variant = 0,
		Strength = 36,
		Cost = 34,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/rf_zombie_orc_warlord"
	},
	{
		XP = 450,
		ActionPoints = 7,
		Hitpoints = 600,
		Bravery = 130,
		Stamina = 100,
		MeleeSkill = 70,
		RangedSkill = 0,
		MeleeDefense = -15,
		RangedDefense = -15,
		Initiative = 60,
		FatigueEffectMult = 0.0,
		MoraleEffectMult = 0.0,
		Armor = [
			0,
			0
		]
	}
);

// OTHER
::Reforged.Entities.editEntity("GrandDiviner",
	null,
	{
		XP = 500,
		ActionPoints = 9,
		Hitpoints = 115,
		Bravery = 130,
		Stamina = 110,
		MeleeSkill = 80,
		RangedSkill = 0,
		MeleeDefense = 15,
		RangedDefense = 35, // vanilla 20
		Initiative = 105,
		FatigueEffectMult = 1.0,
		MoraleEffectMult = 1.0,
		Armor = [
			0,
			0
		]
	}
);
