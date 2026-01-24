local highestID = 0;
foreach (key, value in ::Const.EntityType)
{
	if (typeof value == "integer" && value > highestID)
		highestID = value;
}

::Reforged.Entities <- {
	DefaultFaction = {},

	function addEntity( _entityID, _name, _namePlural, _orientationIcon, _defaultFaction, _troopDef, _actorDef )
	{
		::Const.EntityType[_entityID] <- ++highestID;
		::Const.Strings.EntityName.push(_name);
		::Const.Strings.EntityNamePlural.push(_namePlural);
		::Const.EntityIcon.push(_orientationIcon);
		this.DefaultFaction[highestID] <- _defaultFaction;
		_troopDef.ID <- highestID;
		this.addTroop(_entityID, _troopDef);
		this.addActor(_entityID, _actorDef);
	}

	function addTroop( _key, _troopDef )
	{
		::Const.World.Spawn.Troops[_key] <- _troopDef;
	}

	function addActor( _key, _actorDef )
	{
		::Const.Tactical.Actor[_key] <- _actorDef;
	}

	function addTroopAndActor( _key, _troopDef, _actorDef )
	{
		this.addTroop(_key, _troopDef);
		this.addActor(_key, _actorDef);
	}

	function editEntity( _key, _troopDef = null, _actorDef = null, _function = null )
	{
		if (_troopDef != null)
		{
			::MSU.Table.merge(::Const.World.Spawn.Troops[_key], _troopDef);
		}
		if (_actorDef != null)
		{
			::MSU.Table.merge(::Const.Tactical.Actor[_key], _actorDef);
		}
		if (_function != null)
		{
			_function();
		}
	}
};
