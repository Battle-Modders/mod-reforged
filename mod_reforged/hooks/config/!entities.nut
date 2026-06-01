local highestID = 0;
foreach (key, value in ::Const.EntityType)
{
	if (typeof value == "integer" && value > highestID)
		highestID = value;
}

::Reforged.Entities <- {
	DefaultFaction = {},

	function addEntity( _entityTypeKey, _name, _namePlural, _orientationIcon, _defaultFaction, _troopDef, _actorDef, _atID = null )
	{
		local id;
		if (_atID != null)
		{
			id = _atID;

			foreach (k, v in ::Const.EntityType)
			{
				if (typeof v == "integer" && v >= _atID)
				{
					::Const.EntityType[k] = v + 1;
				}
			}

			foreach (v in ::Const.World.Spawn.Troops)
			{
				if (v.ID >= _atID)
				{
					v.ID += 1;
				}
			}

			highestID++;
		}
		else
		{
			id = ++highestID;
		}

		::Const.EntityType[_entityTypeKey] <- id;
		::Const.Strings.EntityName.insert(id, _name);
		::Const.Strings.EntityNamePlural.insert(id, _namePlural);
		::Const.EntityIcon.insert(id, _orientationIcon);
		this.DefaultFaction[id] <- _defaultFaction;
		_troopDef.ID <- id;
		this.addTroop(_entityTypeKey, _troopDef);
		this.addActor(_entityTypeKey, _actorDef);
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
