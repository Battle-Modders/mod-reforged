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
		this.getSkills().add(::new("scripts/skills/special/rf_veteran_levels"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_dynamic_duo"));
	}

	q.addXP = @(__original) function( _xp, _scale = true )
	{
		if (::Reforged.Config.XPOverride)
			return;

		while (this.m.Level >= ::Const.LevelXP.len())
		{
			::Const.LevelXP.push(::Const.LevelXP.top() + 4000 + 1000 * (::Const.LevelXP.len() - 11));
		}

		return __original(_xp, _scale);
	}

	q.getProjectedAttributes <- function()
	{
		local baseProperties = this.getBaseProperties();

		local ret = {};
		foreach (attributeName, attribute in ::Const.Attributes)
		{
			if (attribute == ::Const.Attributes.COUNT) continue;

			local attributeMin = ::Const.AttributesLevelUp[attribute].Min + ::Math.min(this.m.Talents[attribute], 2);
			local attributeMax = ::Const.AttributesLevelUp[attribute].Max;
			if (this.m.Talents[attribute] == 3) attributeMax++;

			local levelUpsRemaining = ::Math.max(::Const.XP.MaxLevelWithPerkpoints - this.getLevel() + this.getLevelUps(), 0);
			local attributeValue = attributeName == "Fatigue" ? baseProperties["Stamina"] : baseProperties[attributeName]; // Thank you Overhype

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

	q.setStartValuesEx = @() function( _backgrounds, _addTraits = true )
	{
		if (::isSomethingToSee() && ::World.getTime().Days >= 7)
		{
			_backgrounds = ::Const.CharacterPiracyBackgrounds;
		}

		local background = ::new("scripts/skills/backgrounds/" + _backgrounds[::Math.rand(0, _backgrounds.len() - 1)]);
		this.m.Skills.add(background);
		this.m.Background = background;
		this.m.Ethnicity = this.m.Background.getEthnicity();
		background.buildAttributes();
		background.buildDescription();

		if (this.m.Name.len() == 0)
		{
			this.m.Name = background.m.Names[::Math.rand(0, background.m.Names.len() - 1)];
		}

		if (_addTraits)
		{
			local maxTraits = 2; //::Math.rand(::Math.rand(0, 1) == 0 ? 0 : 1, 2); // Vanilla equation
			local traits = [
				background
			];

			for (local i = 0; i < maxTraits; i++)
			{
				for (local j = 0; j < 10; j++)
				{
					local trait = ::Const.CharacterTraits[::Math.rand(0, ::Const.CharacterTraits.len() - 1)];
					local nextTrait = false;

					for (local k = 0; k < traits.len(); k++)
					{
						if (traits[k].getID() == trait[0] || traits[k].isExcluded(trait[0]))
						{
							nextTrait = true;
							break;
						}
					}

					if (!nextTrait)
					{
						traits.push(this.new(trait[1]));
						break;
					}
				}
			}

			for (local i = 1; i < traits.len(); i++)
			{
				this.m.Skills.add(traits[i]);

				if (traits[i].getContainer() != null)
				{
					traits[i].addTitle();
				}
			}
		}

		background.addEquipment();
		background.setAppearance();
		background.buildDescription(true);
		this.m.Skills.update();
		local p = this.m.CurrentProperties;
		this.m.Hitpoints = p.Hitpoints;

		if (_addTraits)
		{
			this.fillTalentValues();
			this.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
		}
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
});
