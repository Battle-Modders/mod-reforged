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
	"RF_VampireLord"
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
]

foreach (entityType in entityTypes)
{
	::Const.EntityType[entityType] <- ++highestID;
}

::Const.EntityIcon.extend(entityIcon);
::Const.EntityIcon[::Const.EntityType.BanditThug] = "rf_bandit_thug_orientation";
::Const.EntityIcon[::Const.EntityType.BanditRaider] = "rf_bandit_raider_orientation";
::Const.EntityIcon[::Const.EntityType.BanditMarksman] = "rf_bandit_marksman_orientation";
::Const.EntityIcon[::Const.EntityType.SkeletonLight] = "rf_skeleton_light_orientation";
::Const.EntityIcon[::Const.EntityType.SkeletonMedium] = "rf_skeleton_medium_orientation";

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
		}
	}

	return ret;
}
