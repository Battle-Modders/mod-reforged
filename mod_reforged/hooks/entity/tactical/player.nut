::Reforged.HooksMod.hook("scripts/entity/tactical/player", function(q) {

	// Player and Non-Player are now using the exact same tooltip-structure again because the only difference of the exact values for progressbar has been streamlined
	// This will make modding easier because now the elements for both types of tooltips have the same IDs
	q.getTooltip = @(__original) function ( _targetedWithSkill = null )
	{
		return this.actor.getTooltip(_targetedWithSkill);
	}

	q.onInit = @(__original) function()
	{
		__original();
		this.getSkills().add(::new("scripts/skills/actives/rf_adjust_dented_armor_ally_skill"));
		this.getSkills().add(::new("scripts/skills/effects/rf_encumbrance_effect"));
		this.getSkills().add(::new("scripts/skills/special/rf_veteran_levels"));
		this.getSkills().add(::new("scripts/skills/special/rf_naked"));

		// +2 because we want to expand the array at least 1 level above this bro so that player.getXPForNextLevel works properly.
		// We do this in onInit in so that when loading a game or spawning a player with high enough level, the array is expanded immediately.
		::Reforged.expandLevelXP(this.m.Level + 2);
	}

	q.addXP = @(__original) function( _xp, _scale = true )
	{
		if (::Reforged.Config.XPOverride)
			return;

		// +2 because we want to expand the array at least 1 level above this bro so that player.getXPForNextLevel works properly
		::Reforged.expandLevelXP(this.m.Level + 2);

		// Temporary buff to vanilla drill sergeant until our Retinue Rework
		if (("State" in ::World) && ::World.State != null && _scale && ::World.Retinue.hasFollower("follower.drill_sergeant"))
		{
			_xp *= ::Math.maxf(1.0, 1.1666 - 0.0166 * (this.m.Level - 1));		// 1.166666 is the exact multiplier to make a 1.2 multiplier into 1.4
		}

		return __original(_xp, _scale);
	}

	// Returns this bro's projected base attributes at level 11 including the effects of traits and permanent injuries
	q.getProjectedAttributes <- function()
	{
		local properties = this.getBaseProperties().getClone();

		// Apply the effects from all traits and permanent injuries
		local wasUpdating = this.getSkills().m.IsUpdating;
		this.getSkills().m.IsUpdating = true;
		foreach (s in this.getSkills().getSkillsByFunction(@( _skill ) _skill.isType(::Const.SkillType.Trait) || _skill.isType(::Const.SkillType.PermanentInjury)))
		{
			s.onUpdate(properties);
		}
		this.getSkills().m.IsUpdating = wasUpdating;

		// Returns the value of the attribute by including _flatChange and then calling the relevant getter function.
		// _flatChange is the projected base change to an attribute due to levelups.
		// This needs to be done because multiplier changes e.g. StaminaMult, which are applied inside the getter functions
		// can be modified by traits/permanent injuries. So we modify the flat value with levelups then call the getter.
		local function getProjection( _attributeName, _flatChange )
		{
			// Thank you Overhype
			local propertyName = _attributeName == "Fatigue" ? "Stamina" : _attributeName;

			local ret = 0;
			properties[propertyName] += _flatChange;
			switch (_attributeName)
			{
				case "Fatigue":
				case "Hitpoints":
					ret = this["get" + _attributeName + "Max"]();
					break;

				default:
					ret = properties["get" + _attributeName]();
			}
			properties[propertyName] -= _flatChange;
			return ret;
		}

		local levelUpsRemaining = ::Math.max(::Const.XP.MaxLevelWithPerkpoints - this.getLevel() + this.getLevelUps(), 0);

		// Fatigue and Hitpoints getter functions are in actor and they use CurrentProperties
		// so we temporarily switcheroo the CurrentProperties to get our desired values
		local original_CurrentProperties = this.m.CurrentProperties;
		this.m.CurrentProperties = properties;

		local ret = {};
		foreach (attributeName, attribute in ::Const.Attributes)
		{
			if (attribute == ::Const.Attributes.COUNT) continue;

			local levelupMin = ::Const.AttributesLevelUp[attribute].Min + ::Math.min(this.m.Talents[attribute], 2);
			local levelupMax = ::Const.AttributesLevelUp[attribute].Max;
			if (this.m.Talents[attribute] == 3) levelupMax++;

			// For each "randomized" level-up for 2-star talents, decrease min projection by 1 and increase max projection by 1
			local attributeTotalMod = 0;
			if (this.m.Talents[attribute] == 2)
			{
				foreach (value in this.m.Attributes[attribute])
				{
					if (value != levelupMax)
						attributeTotalMod++;
				}
			}

			ret[attribute] <- [
				getProjection(attributeName, levelupMin * levelUpsRemaining - attributeTotalMod),
				getProjection(attributeName, levelupMax * levelUpsRemaining + attributeTotalMod)
			];
		}

		this.m.CurrentProperties = original_CurrentProperties;

		return ret;
	}

	q.isHired <- function()
	{
		return this.getPlaceInFormation() != 255;
	}

	q.MV_getMaxStartingTraits = @() function()
	{
		return 2;
	}

	// Adjust attributes with 2 stars to also grant random stats instead of fixed stats each level-up
	q.fillAttributeLevelUpValues = @(__original) function( _amount, _maxOnly = false, _minOnly = false )
	{
		__original(_amount, _maxOnly, _minOnly);

		if (_amount < 2) return;
		if (_maxOnly || _minOnly) return;	// Stars do not influence these level-ups

		for (local i = 0; i != ::Const.Attributes.COUNT; i++)
		{
			if (this.m.Talents[i] == 2)
			{
				local indices = array(_amount);
				foreach (j, _ in indices)
				{
					indices[j] = j;
				}
				// Randomize half of the level-ups added by -1 or +1
				for (local j = 0; j < _amount / 2; j++)
				{
					this.m.Attributes[i][indices.remove(::Math.rand(0, indices.len() - 1))] += ::Math.rand(0, 1) == 0 ? -1 : 1;
				}
			}
		}
	}

	q.setAttributeLevelUpValues = @(__original) function( _v )
	{
		__original(_v);
		local discoveredTalent = this.getSkills().getSkillByID("perk.rf_discovered_talent");
		if (discoveredTalent != null) discoveredTalent.addStars();
	}
});
