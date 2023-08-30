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
	"RF_BanditBaron"
]

local entityIcon = [
	"bandit_thug_orientation",
	"bandit_raider_orientation",
	"bandit_marksman_orientation",
	"bandit_raider_orientation",
	"bandit_raider_orientation",
	"bandit_raider_orientation",
	"bandit_raider_orientation",
	"bandit_raider_orientation",
	"bandit_raider_orientation",
	"bandit_raider_orientation",
	"bandit_marksman_orientation",
	"bandit_leader_orientation"
]

foreach (entityType in entityTypes)
{
	::Const.EntityType[entityType] <- ++highestID;
}

::Const.EntityIcon.extend(entityIcon);

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
		}
	}

	return ret;
}
