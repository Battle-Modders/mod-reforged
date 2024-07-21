::logWarning("------ Applying Reforged modifications to MSU ------");

::logInfo("Reforged::MSU -- adding ::MSU.new");
::MSU.new <- function( _script, _function = null )
{
	local obj = ::new(_script);
	if (_function != null) _function(obj);
	return obj;
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
