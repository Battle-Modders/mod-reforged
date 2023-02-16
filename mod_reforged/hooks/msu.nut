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
		return options.InvertColor ? this.colorGreen(_value) : this.colorRed(_value);
	}

	if (_value > options.CompareTo)
	{
		if (options.AddSign && _value > 0) _value = "+" + _value;
		if (options.AddPercent) _value = _value + "%";
		return options.InvertColor ? this.colorRed(_value) : this.colorGreen(_value);
	}

	if (_value == options.CompareTo)
	{
		if (options.AddPercent) _value = _value + "%";
		return _value;
	}
}

::logInfo("Reforged::MSU -- adding ::MSU.Text.colorizePercentage");
::MSU.Text.colorizePercentage <- function( _value, _options = null )
{
	if (_options == null) _options = {};
	_options.AddPercent <- true;
	return this.colorizeValue(_value, _options);
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
::mods_hookNewObject("entity/tactical/tactical_entity_manager", function(o) {
	// VANILLAFIX: http://battlebrothersgame.com/forums/topic/oncombatstarted-is-not-called-for-ai-characters/
	local spawn = o.spawn;
	o.spawn = function( _properties )
	{
		local ret = spawn(_properties);
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

::logInfo("Reforged::MSU -- adding BaseWeaponScript for named_weapon");
::mods_hookExactClass("items/weapons/named/named_weapon", function(o) {
	o.m.BaseWeaponScript <- null;

	o.getValuesForRandomize <- function()
	{
		if (this.m.BaseWeaponScript == null) return {};

		local baseWeapon = ::new(this.m.BaseWeaponScript);
		return {
			Condition = baseWeapon.m.Condition,
			ConditionMax = baseWeapon.m.ConditionMax,
			RegularDamage = baseWeapon.m.RegularDamage,
			RegularDamageMax = baseWeapon.m.RegularDamageMax,
			ArmorDamageMult = baseWeapon.m.ArmorDamageMult,
			ChanceToHitHead = baseWeapon.m.ChanceToHitHead,
			DirectDamageMult = baseWeapon.m.DirectDamageMult,
			DirectDamageAdd = baseWeapon.m.DirectDamageAdd,
			StaminaModifier = baseWeapon.m.StaminaModifier,
			ShieldDamage = baseWeapon.m.ShieldDamage,
			AdditionalAccuracy = baseWeapon.m.AdditionalAccuracy,
			FatigueOnSkillUse = baseWeapon.m.FatigueOnSkillUse,

			IsAoE = baseWeapon.m.IsAoE,
			SlotType = baseWeapon.m.SlotType,
			ItemType = this.m.ItemType | baseWeapon.m.ItemType,
			WeaponType = baseWeapon.m.WeaponType,
			BlockedSlotType = baseWeapon.m.BlockedSlotType,
			IsDoubleGrippable = baseWeapon.m.IsDoubleGrippable,
			IsAgainstShields = baseWeapon.m.IsAgainstShields,
			AddGenericSkill = baseWeapon.m.AddGenericSkill,
			ShowQuiver = baseWeapon.m.ShowQuiver,
			ShowArmamentIcon = baseWeapon.m.ShowArmamentIcon,
			ShieldDamage = baseWeapon.m.ShieldDamage,
			RangeMin = baseWeapon.m.RangeMin,
			RangeMax = baseWeapon.m.RangeMax,
			RangeIdeal = baseWeapon.m.RangeIdeal,

			// Reforged stuff -- should be removed when porting to MSU
			Reach = baseWeapon.m.Reach
		};
	}

	o.setValuesBeforeRandomize <- function( _values )
	{
		foreach (key, value in _values)
		{
			this.m[key] = value;
		}
	}

	local randomizeValues = o.randomizeValues;
	o.randomizeValues <- function()
	{
		this.setValuesBeforeRandomize(this.getValuesForRandomize());
		randomizeValues();
	}
});

::logInfo("Reforged::MSU -- adding onSkillsUpdated event");
::mods_hookNewObject("skills/skill_container", function(o) {
	local update = o.update;
	o.update = function()
	{
		update();
		if (!this.m.IsUpdating && this.getActor().isAlive())
			this.onSkillsUpdated();
	}

	o.onSkillsUpdated <- function()
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

::mods_hookBaseClass("skills/skill", function(o) {
	o = o[o.SuperName];

	o.onSkillsUpdated <- function()
	{
	}
})

::logWarning("------ Reforged modifications to MSU Finished------");
