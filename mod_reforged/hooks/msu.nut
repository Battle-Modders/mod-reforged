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
::MSU.Text.colorizeMult <- function( _value, _options = null )
{
	if (_options == null) _options = {};
	if (!("AddSign" in _options)) _options.AddSign <- false;
	_options.AddPercent <- true;
	return this.colorizeValue((_value - 1.0) * 100, _options);
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

::logInfo("Reforged::MSU -- adding BaseWeaponScript for named_weapon");
::Reforged.HooksMod.hook("scripts/items/weapons/named/named_weapon", function(q) {
	q.m.BaseWeaponScript <- null;

	q.getValuesForRandomize <- function()
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

	q.setValuesBeforeRandomize <- function( _values )
	{
		foreach (key, value in _values)
		{
			this.m[key] = value;
		}
	}

	q.randomizeValues = @(__original) function()
	{
		this.setValuesBeforeRandomize(this.getValuesForRandomize());
		__original();
	}
});

::logInfo("Reforged::MSU -- adding BaseItemScript for named_shield");
::Reforged.HooksMod.hook("scripts/items/shields/named/named_shield", function(q) {
	q.m.BaseItemScript <- null;

	q.getValuesForRandomize <- function()
	{
		if (this.m.BaseItemScript == null) return {};

		local baseItem = ::new(this.m.BaseItemScript);
		return {
			Condition = baseItem.m.Condition,
			ConditionMax = baseItem.m.ConditionMax,
			MeleeDefense = baseItem.m.MeleeDefense,
			RangedDefense = baseItem.m.RangedDefense,
			StaminaModifier = baseItem.m.StaminaModifier,
			ReachIgnore = baseItem.m.ReachIgnore
		};
	}

	q.setValuesBeforeRandomize <- function( _values )
	{
		foreach (key, value in _values)
		{
			this.m[key] = value;
		}
	}

	q.randomizeValues = @(__original) function()
	{
		this.setValuesBeforeRandomize(this.getValuesForRandomize());
		__original();
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
	q.m.ParentSkill <- null;
	q.m.ChildSkills <- [];

	q.onRemoved = @(__original) function()
	{
		__original();
		this.clearChilds();
	}

// New Functions
	q.onSkillsUpdated <- function()
	{
	}

	q.setParent <- function( _parentSkill )
	{
		if (_parentSkill == null)
		{
			this.m.ParentSkill = null;
		}
		else
		{
			this.m.ParentSkill = ::MSU.asWeakTableRef(_parentSkill);
		}
	}

	q.getParent <- function()
	{
		return this.m.ParentSkill;
	}

	q.addChild <- function( _childSkill )
	{
		this.m.ChildSkills.push(::MSU.asWeakTableRef(_childSkill));
		this.getContainer().add(_childSkill, this.m.ChildSkills.len());
		_childSkill.setParent(this);
	}

	q.clearChilds <- function()
	{
		foreach (childSkill in this.m.ChildSkills)
		{
			if (childSkill != null)
			{
				this.getContainer().remove(childSkill);
			}
		}
	}
});

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

::logWarning("------ Reforged modifications to MSU Finished------");
