local highestID = 0;
foreach (key, value in ::Const.EntityType)
{
	if (typeof value == "integer" && value > highestID)
		highestID = value;
}

local entityTypes = [
	"RF_BanditScoundrel",
	"RF_BanditRobber",
	"RF_BanditHunter",
	"RF_BanditVandal",
	"RF_BanditPillager",
	"RF_BanditOutlaw",
	"RF_BanditBandit",
	"RF_BanditHighwayman",
	"RF_BanditMarauder",
	"RF_BanditKiller",
	"RF_BanditSharpshooter",
	"RF_BanditBaron",

	"RF_SkeletonLightElite",
	"RF_SkeletonMediumElite",
	"RF_SkeletonHeavyLesser",
	"RF_SkeletonDecanus",
	"RF_SkeletonCenturion",
	"RF_SkeletonLegatus",
	"RF_VampireLord",

	"RF_FootmanHeavy",
	"RF_BillmanHeavy",
	"RF_ArbalesterHeavy",
	"RF_Herald",
	"RF_Marshal",
	"RF_ManAtArms",
	"RF_Fencer",
	"RF_KnightAnointed",
	"RF_Squire",
	"RF_HeraldsBodyguard"
]

local entityIcon = [
	"bandit_thug_orientation",
	"rf_bandit_robber_orientation",
	"rf_bandit_hunter_orientation",
	"bandit_raider_orientation",
	"rf_bandit_pillager_orientation",
	"rf_bandit_outlaw_orientation",
	"rf_bandit_bandit_orientation",
	"rf_bandit_highwayman_orientation",
	"rf_bandit_marauder_orientation",
	"rf_bandit_killer_orientation",
	"rf_bandit_sharpshooter_orientation",
	"rf_bandit_baron_orientation"

	"rf_skeleton_light_elite_orientation",
	"rf_skeleton_medium_elite_orientation",
	"rf_skeleton_heavy_lesser_orientation",
	"rf_skeleton_decanus_orientation",
	"rf_skeleton_centurion_orientation",
	"rf_skeleton_legatus_orientation",
	"rf_vampire_lord_orientation"

	"rf_footman_heavy_orientation",
	"rf_billman_heavy_orientation",
	"rf_arbalester_heavy_orientation",
	"rf_herald_orientation",
	"rf_marshal_orientation",
	"rf_man_at_arms_orientation",
	"rf_fencer_orientation",
	"rf_knight_anointed_orientation",
	"rf_squire_orientation",
	"rf_heralds_bodyguard_orientation"
]

foreach (entityType in entityTypes)
{
	::Const.EntityType[entityType] <- ++highestID;
}

::Const.Strings.EntityName[::Const.EntityType.Arbalester] = "Crossbowman";
::Const.Strings.EntityNamePlural[::Const.EntityType.Arbalester] = "Crossbowmen";

::Const.EntityIcon.extend(entityIcon);
::Const.EntityIcon[::Const.EntityType.BanditThug] = "rf_bandit_thug_orientation";
::Const.EntityIcon[::Const.EntityType.BanditRaider] = "rf_bandit_raider_orientation";
::Const.EntityIcon[::Const.EntityType.BanditMarksman] = "rf_bandit_marksman_orientation";
::Const.EntityIcon[::Const.EntityType.SkeletonLight] = "rf_skeleton_light_orientation";
::Const.EntityIcon[::Const.EntityType.SkeletonMedium] = "rf_skeleton_medium_orientation";
::Const.EntityIcon[::Const.EntityType.StandardBearer] = "rf_standard_bearer_orientation";
::Const.EntityIcon[::Const.EntityType.Sergeant] = "rf_sergeant_orientation";

local getDefaultFaction = ::Const.EntityType.getDefaultFaction;
::Const.EntityType.getDefaultFaction = function( _id )
{
	local ret = getDefaultFaction(_id);
	if (ret == ::Const.FactionType.Generic)
	{
		switch( _id )
		{
			case ::Const.EntityType.RF_BanditScoundrel:
			case ::Const.EntityType.RF_BanditRobber:
			case ::Const.EntityType.RF_BanditHunter:
			case ::Const.EntityType.RF_BanditVandal:
			case ::Const.EntityType.RF_BanditPillager:
			case ::Const.EntityType.RF_BanditOutlaw:
			case ::Const.EntityType.RF_BanditBandit:
			case ::Const.EntityType.RF_BanditHighwayman:
			case ::Const.EntityType.RF_BanditMarauder:
			case ::Const.EntityType.RF_BanditKiller:
			case ::Const.EntityType.RF_BanditSharpshooter:
			case ::Const.EntityType.RF_BanditBaron:
				return ::Const.FactionType.Bandits;

			case ::Const.EntityType.RF_SkeletonLightElite:
			case ::Const.EntityType.RF_SkeletonMediumElite:
			case ::Const.EntityType.RF_SkeletonHeavyLesser:
			case ::Const.EntityType.RF_SkeletonDecanus:
			case ::Const.EntityType.RF_SkeletonCenturion:
			case ::Const.EntityType.RF_SkeletonLegatus:
			case ::Const.EntityType.RF_VampireLord:
				return ::Const.FactionType.Undead;

			case ::Const.EntityType.RF_FootmanHeavy:
			case ::Const.EntityType.RF_BillmanHeavy:
			case ::Const.EntityType.RF_ArbalesterHeavy:
			case ::Const.EntityType.RF_Herald:
			case ::Const.EntityType.RF_Marshal:
			case ::Const.EntityType.RF_ManAtArms:
			case ::Const.EntityType.RF_Fencer:
			case ::Const.EntityType.RF_KnightAnointed:
			case ::Const.EntityType.RF_Squire:
			case ::Const.EntityType.RF_HeraldsBodyguard:
				return ::Const.FactionType.NobleHouse;
		}
	}

	return ret;
}

// The lowest two difficulties are now the same
::Const.Difficulty.EnemyMult[0] = ::Const.Difficulty.EnemyMult[1];
::Const.Difficulty.EnemyMult[2] += 0.05;
::Const.Difficulty.NPCDamageMult <- [
	0.9,
	1.0,
	1.0
]
::Const.Difficulty.generateTooltipInfo <- function( _tooltip, _difficulty )
{
	if (::Const.Difficulty.XPMult[_difficulty] != 1.0)
	{
		_tooltip.push({
			id = 4,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = ::MSU.Text.colorizeMult(::Const.Difficulty.XPMult[_difficulty], {AddSign = true}) + " Global Experience gained"
		})
	}

	if (_difficulty == ::Const.Difficulty.Easy)
	{
		_tooltip.push({
			id = 3,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "Your characters have " + ::MSU.Text.colorGreen("+5%") + " chance to hit"
		})
		_tooltip.push({
			id = 3,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "Attacks against your characters have " + ::MSU.Text.colorRed("-5%") + " chance to hit"
		})
	}

	if (::Const.Difficulty.NPCDamageMult[_difficulty] != 1.0)
	{
		_tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::MSU.Text.colorizeMult(::Const.Difficulty.NPCDamageMult[_difficulty], {AddSign = true}) + " Damage dealt by all other characters"
		})
	}

	if (::Const.Difficulty.RetreatDefenseBonus[_difficulty] != 0)
	{
		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::MSU.Text.colorizeValue(::Const.Difficulty.RetreatDefenseBonus[_difficulty]) + " Melee Defense during Auto-Retreat"
		})
	}

	if (::Const.Difficulty.EnemyMult[_difficulty] != 1.0)
	{
		_tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/camp.png",
			text = ::MSU.Text.colorizeMult(::Const.Difficulty.EnemyMult[_difficulty], {AddSign = true}) + " Enemy Party Resources"
		})
	}
}
