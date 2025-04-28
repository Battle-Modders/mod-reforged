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
	}

	q.addXP = @(__original) function( _xp, _scale = true )
	{
		if (::Reforged.Config.XPOverride)
			return;

		while (this.m.Level >= ::Const.LevelXP.len())
		{
			::Const.LevelXP.push(::Const.LevelXP.top() + 4000 + 1000 * (::Const.LevelXP.len() - 11));
		}

		// Temporary buff to vanilla drill sergeant until our Retinue Rework
		if (("State" in ::World) && ::World.State != null && _scale && ::World.Retinue.hasFollower("follower.drill_sergeant"))
		{
			_xp *= ::Math.maxf(1.0, 1.1666 - 0.0166 * (this.m.Level - 1));		// 1.166666 is the exact multiplier to make a 1.2 multiplier into 1.4
		}

		return __original(_xp, _scale);
	}

	q.getProjectedAttributes <- function()
	{
		local properties = this.getBaseProperties().getClone();

		local wasUpdating = this.getSkills().m.IsUpdating;
		this.getSkills().m.IsUpdating = true;
		foreach (s in this.getSkills().getSkillsByFunction(@( _skill ) _skill.isType(::Const.SkillType.Trait) || _skill.isType(::Const.SkillType.PermanentInjury)))
		{
			s.onUpdate(properties);
		}
		this.getSkills().m.IsUpdating = wasUpdating;

		local ret = {};
		foreach (attributeName, attribute in ::Const.Attributes)
		{
			if (attribute == ::Const.Attributes.COUNT) continue;

			local attributeMin = ::Const.AttributesLevelUp[attribute].Min + ::Math.min(this.m.Talents[attribute], 2);
			local attributeMax = ::Const.AttributesLevelUp[attribute].Max;
			if (this.m.Talents[attribute] == 3) attributeMax++;

			local levelUpsRemaining = ::Math.max(::Const.XP.MaxLevelWithPerkpoints - this.getLevel() + this.getLevelUps(), 0);

			local attributeValue;
			switch (attributeName)
			{
				// Fatigue and Hitpoints getter functions are in actor and they use CurrentProperties
				// so we temporarily switcheroo the CurrentProperties to get our desired values
				case "Fatigue":
				case "Hitpoints":
					local original_CurrentProperties = this.m.CurrentProperties;
					this.m.CurrentProperties = properties;
					attributeValue = this["get" + attributeName + "Max"]();
					this.m.CurrentProperties = original_CurrentProperties;
					break;

				default:
					attributeValue = properties["get" + attributeName]();
			}

			// For each "randomized" level-up for 2-star talents, decrease min projection by 1 and increase max projection by 1
			local attributeTotalMod = 0;
			if (this.m.Talents[attribute] == 2)
			{
				foreach (value in this.m.Attributes[attribute])
				{
					if (value != attributeMax) attributeTotalMod++;
				}
			}

			ret[attribute] <- [
				attributeValue - attributeTotalMod + attributeMin * levelUpsRemaining,
				attributeValue + attributeTotalMod + attributeMax * levelUpsRemaining
			];
		}

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
