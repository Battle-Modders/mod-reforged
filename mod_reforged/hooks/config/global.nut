local extendEntities = function( _entityArray )
{
	local idValue = 0;
	foreach (value in ::Const.EntityType)
	{
		if (typeof value == "integer" && value > idValue)
		idValue = value;
	}

	foreach (entity in _entityArray)
	{
		addEntity( entity.Key, entity.Icon, entity.Name, entity.NamePlural, idValue);
		++idValue;
	}
}

local addEntity = function( _entityKey, _icon, _name, _namePlural, _idValue = null)
{
	if (_idValue == null)
	{
		local _idValue = 0;
		foreach (value in ::Const.EntityType)
		{
			if (typeof value == "integer" && value > _idValue)
			_idValue = value;
		}
	}

	::Const.EntityType[_entityKey] <- _idValue;
	::Const.EntityIcon.push(_icon);
	::Const.Strings.EntityName.push(_name);
	::Const.Strings.EntityNamePlural.push(_namePlural);
}

// Bandits
extendEntities([
	{
		Key = "RF_BanditScoundrel",
		Icon = "bandit_thug_orientation",
		Name = "Brigand Scoundrel",
		NamePlural = "Brigand Scoundrels"
	},
	{
		Key = "RF_BanditRobber",
		Icon = "rf_bandit_robber_orientation",
		Name = "Brigand Robber",
		NamePlural = "Brigand Robbers"
	},
	{
		Key = "RF_BanditHunter",
		Icon = "rf_bandit_hunter_orientation",
		Name = "Brigand Hunter",
		NamePlural = "Brigand Hunters"
	},
	{
		Key = "RF_BanditVandal",
		Icon = "bandit_raider_orientation",
		Name = "Brigand Vandal",
		NamePlural = "Brigand Vandals"
	},
	{
		Key = "RF_BanditPillager",
		Icon = "rf_bandit_pillager_orientation",
		Name = "Brigand Pillager",
		NamePlural = "Brigand Pillagers"
	},
	{
		Key = "RF_BanditOutlaw",
		Icon = "rf_bandit_outlaw_orientation",
		Name = "Brigand Outlaw",
		NamePlural = "Brigand Outlaws"
	},
	{
		Key = "RF_BanditBandit",
		Icon = "rf_bandit_bandit_orientation",
		Name = "Brigand Bandit",
		NamePlural = "Brigand Bandits"
	},
	{
		Key = "RF_BanditHighwayman",
		Icon = "rf_bandit_highwayman_orientation",
		Name = "Brigand Highwayman",
		NamePlural = "Brigand Highwaymen"
	},
	{
		Key = "RF_BanditMarauder",
		Icon = "rf_bandit_marauder_orientation",
		Name = "Brigand Marauder",
		NamePlural = "Brigand Marauders"
	},
	{
		Key = "RF_BanditKiller",
		Icon = "rf_bandit_killer_orientation",
		Name = "Brigand Killer",
		NamePlural = "Brigand Killers"
	},
	{
		Key = "RF_BanditSharpshooter",
		Icon = "rf_bandit_sharpshooter_orientation",
		Name = "Brigand Sharpshooter",
		NamePlural = "Brigand Sharpshooters"
	},
	{
		Key = "RF_BanditBaron",
		Icon = "rf_bandit_baron_orientation",
		Name = "Brigand Baron",
		NamePlural = "Brigand Barons"
	},
])

// Skeletons
extendEntities([
	{
		Key = "RF_SkeletonLightElite",
		Icon = "rf_skeleton_light_elite_orientation",
		Name = "Ancient Miles",
		NamePlural = "Ancient Milites"
	},
	{
		Key = "RF_SkeletonMediumElite",
		Icon = "rf_skeleton_medium_elite_orientation",
		Name = "Ancient Palatinus",
		NamePlural = "Ancient Palatini"
	},
	{
		Key = "RF_SkeletonHeavyLesser",
		Icon = "rf_skeleton_heavy_lesser_orientation",
		Name = "Ancient Praetorian",
		NamePlural = "Ancient Praetorians"
	},
	{
		Key = "RF_SkeletonDecanus",
		Icon = "rf_skeleton_decanus_orientation",
		Name = "Ancient Decanus",
		NamePlural = "Ancient Decani"
	},
	{
		Key = "RF_SkeletonCenturion",
		Icon = "rf_skeleton_centurion_orientation",
		Name = "Ancient Centurion",
		NamePlural = "Ancient Centurions"
	},
	{
		Key = "RF_SkeletonLegatus",
		Icon = "rf_skeleton_legatus_orientation",
		Name = "Ancient Legati",
		NamePlural = "Ancient Legatus"
	},
	{
		Key = "RF_VampireLord",
		Icon = "rf_vampire_lord_orientation",
		Name = "Necrosavant Lord",
		NamePlural = "Necrosavant Lords"
	},
])

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
