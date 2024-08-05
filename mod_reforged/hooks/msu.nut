::logWarning("------ Applying Reforged modifications to MSU ------");

::logInfo("Reforged::MSU -- adding ::MSU.new");
::MSU.new <- function( _script, _function = null )
{
	local obj = ::new(_script);
	if (_function != null) _function(obj);
	return obj;
}

// Removes all duplicates from an array and returns a new now-unique array
::logInfo("Reforged::MSU -- adding ::MSU.Array.removeDuplicates");
::MSU.Array.removeDuplicates <- function( _array )
{
	local arrayTable = {};
	foreach (entry in _array)
	{
		arrayTable[entry] <- null;	// The value doesn't matter here. We just put in some random value
	}

	return ::MSU.Table.keys(arrayTable);
}

::logInfo("Reforged::MSU -- adding ::MSU.Text.colorizeValue");
::MSU.Text.colorizeValue <- function( _value, _options = null )
{
	local options = {
		AddSign = true,
		CompareTo = 0,
		InvertColor = false,
		AddPercent = false
	};

	if (_options != null)
	{
		foreach (key, value in _options)
		{
			if (!(key in options)) throw "invalid parameter " + key;
			options[key] = value;
		}
	}

	if (_value < options.CompareTo)
	{
		if (!options.AddSign && _value < 0) _value *= -1;
		if (options.AddPercent) _value = _value + "%";
		return options.InvertColor ? this.colorPositive(_value) : this.colorNegative(_value);
	}

	if (_value > options.CompareTo)
	{
		if (options.AddSign && _value > 0) _value = "+" + _value;
		if (options.AddPercent) _value = _value + "%";
		return options.InvertColor ? this.colorNegative(_value) : this.colorPositive(_value);
	}

	if (_value == options.CompareTo)
	{
		if (options.AddPercent) _value = _value + "%";
		return _value;
	}
}


::logInfo("Reforged::MSU -- adding ::MSU.Time.getSecondsRequiredToTravel");
::MSU.Time <- {
	function getSecondsRequiredToTravel( _numTiles, _speed, _onRoadOnly = false )	// This is a close copy of how vanilla calculates their distance duration
	{
		_speed *= ::Const.World.MovementSettings.GlobalMult;
		if (_onRoadOnly) _speed *= ::Const.World.MovementSettings.RoadMult;
		return _numTiles * 170.0 / _speed;
	}
}

::logInfo("Reforged::MSU -- adding ::MSU.Text.colorizePercentage");
::MSU.Text.colorizePercentage <- function( _value, _options = null )
{
	if (_options == null) _options = {};
	_options.AddPercent <- true;
	return this.colorizeValue(_value, _options);
}

::logInfo("Reforged::MSU -- adding ::MSU.Text.colorizeMult");
::MSU.Text.colorizeMult <- function( _value, _options = null )		// will turn values like 1.45 into a formatted and colored 45%
{
	if (_options == null) _options = {};
	if (!("AddSign" in _options)) _options.AddSign <- false;
	_options.AddPercent <- true;
	return this.colorizeValue(::Math.round((_value - 1.0) * 100), _options);
}

::logInfo("Reforged::MSU -- adding ::MSU.Text.colorizeFraction");
::MSU.Text.colorizeFraction <- function( _value, _options = null )	// will turn values like 0.2 into a formatted and colored 20%
{
	if (_value < 0)
	{
		throw ::MSU.Exception.InvalidValue(_value);
	}

	if (_options == null) _options = {};
	if (!("AddSign" in _options)) _options.AddSign <- false;
	_options.AddPercent <- true;
	return this.colorizeValue(::Math.round(_value * 100), _options);
}

::logInfo("Reforged::MSU -- adding ::MSU.Text.colorDamage");
::MSU.Text.colorDamage <- function( _string )
{
	return ::MSU.Text.color(::Const.UI.Color.DamageValue, _string);
}

::logInfo("Reforged::MSU -- adding ::MSU.Tile.getNeighbors");
::MSU.Tile.getNeighbors <- function( _tile, _function = null )
{
	local ret = [];
	for (local i = 0; i < 6; i++)
	{
		if (_tile.hasNextTile(i))
		{
			local nextTile = _tile.getNextTile(i);
			if (_function == null || _function(nextTile))
				ret.push(nextTile);
		}
	}
	return ret;
}

::logInfo("Reforged::MSU -- adding ::MSU.Tile.getNeighbor");
::MSU.Tile.getNeighbor <- function( _tile, _function = null )
{
	for (local i = 0; i < 6; i++)
	{
		if (_tile.hasNextTile(i))
		{
			local nextTile = _tile.getNextTile(i);
			if (_function == null || _function(nextTile))
				return nextTile;
		}
	}
}

::logInfo("Reforged::MSU -- adding fix for onCombatStarted for AI");
::Reforged.HooksMod.hook("scripts/entity/tactical/tactical_entity_manager", function(q) {
	// VANILLAFIX: http://battlebrothersgame.com/forums/topic/oncombatstarted-is-not-called-for-ai-characters/
	q.spawn = @(__original) function( _properties )
	{
		local ret = __original(_properties);
		foreach (i, faction in this.getAllInstances())
		{
			if (i != ::Const.Faction.Player)
			{
				foreach (actor in faction)
				{
					actor.getSkills().onCombatStarted();
					actor.getItems().onCombatStarted();
					actor.getSkills().update();
				}
			}
		}

		::Math.seedRandom(::Time.getRealTime());

		return ret;
	}
});

::logInfo("Reforged::MSU -- adding onSkillsUpdated event");
::Reforged.HooksMod.hook("scripts/skills/skill_container", function(q) {
	q.update = @(__original) function()
	{
		__original();
		if (!this.m.IsUpdating && this.getActor().isAlive())
			this.onSkillsUpdated();
	}

	q.onSkillsUpdated <- function()
	{
		this.callSkillsFunctionWhenAlive("onSkillsUpdated", null, false);

		local shouldUpdate = this.m.SkillsToAdd.len() > 0;
		if (!shouldUpdate)
		{
			foreach (skill in this.m.Skills)
			{
				if (skill.isGarbage())
				{
					shouldUpdate = true;
					break;
				}
			}
		}

		if (shouldUpdate) this.update();
	}
});

::Reforged.HooksMod.hook("scripts/skills/skill", function(q) {
	q.onSkillsUpdated <- function()
	{
	}
})

::logInfo("Reforged::MSU -- adding getItemsByFunction and getItemsByFunctionAtSlot to item_container");
::Reforged.HooksMod.hook("scripts/items/item_container", function(q) {
	q.getItemsByFunction <- function( _function )
	{
		local ret = [];

		for (local i = 0; i < ::Const.ItemSlot.COUNT; i++)
		{
			for (local j = 0; j < ::Const.ItemSlotSpaces[i]; j++)
			{
				local item = this.m.Items[i][j];
				if (item != null && item != -1 && _function(item))
					ret.push(item);
			}
		}

		return ret;
	}

	q.getItemsByFunctionAtSlot <- function( _slot, _function )
	{
		local ret = [];

		for (local i = 0; i < ::Const.ItemSlotSpaces[_slot]; i++)
		{
			local item = this.m.Items[_slot][i];
			if (item != null && item != -1 && _function(item))
				ret.push(item);
		}

		return ret;
	}
});

::logInfo("Reforged::MSU -- adding ::MSU.Array.removeValues");
::MSU.Array.removeValues <- function( _array, _values )
{
	for (local i = _array.len() - 1; i > 0; i--)
	{
		if (_values.find(_array[i]) != null)
		{
			_array.remove(i);
		}
	}
}

::logWarning("------ Reforged modifications to MSU Finished------");
