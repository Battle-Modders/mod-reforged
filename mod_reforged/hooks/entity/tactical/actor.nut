::mods_hookExactClass("entity/tactical/actor", function(o) {
	o.m.IsPerformingAttackOfOpportunity <- false;

	o.isDisarmed <- function()
	{
		local handToHand = this.getSkills().getSkillByID("actives.hand_to_hand");
		return handToHand != null && handToHand.isUsable();
	}

	local onInit = o.onInit;
	o.onInit = function()
	{
		onInit();
		this.getSkills().add(::new("scripts/skills/effects/rf_encumbrance_effect"));
		this.getSkills().add(::new("scripts/skills/effects/rf_inspired_by_champion_effect"));
		this.getSkills().add(::new("scripts/skills/effects/rf_immersive_damage_effect"));
		this.getSkills().add(::new("scripts/skills/special/rf_reach"));
		this.getSkills().add(::new("scripts/skills/special/rf_formidable_approach_manager"));
		this.getSkills().add(::new("scripts/skills/special/rf_direct_damage_limiter"));
		this.getSkills().add(::new("scripts/skills/special/rf_polearm_adjacency"));
		this.getSkills().add(::new("scripts/skills/special/rf_follow_up_proccer"));
		this.getSkills().add(::new("scripts/skills/special/rf_inspiring_presence_buff_effect"));

		local flags = this.getFlags();
		if (flags.has("undead") && !flags.has("ghost") && !flags.has("ghoul") && !flags.has("vampire"))
		{
			this.getSkills().add(::new("scripts/skills/effects/rf_undead_injury_receiver_effect"));
			if (flags.has("skeleton"))
			{
				this.m.ExcludedInjuries.extend(::Const.Injury.ExcludedInjuries.get(::Const.Injury.ExcludedInjuries.RF_Skeleton));
			}
			else
			{
				this.m.ExcludedInjuries.extend(::Const.Injury.ExcludedInjuries.get(::Const.Injury.ExcludedInjuries.RF_Undead));
			}
		}
	}

	local onAttackOfOpportunity = o.onAttackOfOpportunity;
	o.onAttackOfOpportunity = function( _entity, _isOnEnter )
	{
		this.m.IsPerformingAttackOfOpportunity = true;
		local ret = onAttackOfOpportunity(_entity, _isOnEnter);
		this.m.IsPerformingAttackOfOpportunity = false;
		return ret;
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function( _targetedWithSkill = null )
	{
		local ret = getTooltip(_targetedWithSkill);

		if (this.isDiscovered() == false) return ret;
		if (this.isHiddenToPlayer()) return ret;

		local toRemove = [];

		// Adjust existing progressbars displayed by Vanilla
		foreach(index, entry in ret)
		{
			// Display the actual values for Armor (5, 6), Health (7) and Fatigue (9)
			if (entry.id == 5 || entry.id == 6 || entry.id == 7 || entry.id == 9)
			{
				entry.text = " " + entry.value + " / " + entry.valueMax;
			}

			if (entry.id == 8)	// Replace Morale-Bar with Action-Point-Bar
			{
				local turnsToGo = ::Tactical.TurnSequenceBar.getTurnsUntilActive(this.getID());

				entry.icon = "ui/icons/action_points.png",
				entry.value = this.getActionPoints(),
				entry.valueMax = this.getActionPointsMax(),
				entry.text = "" + this.getActionPoints() + " / " + this.getActionPointsMax() + "",
				entry.style = "action-points-slim";
				continue;
			}

			// Remove all vanilla generated effect entries but possible also most mod-generated entries
			if (entry.id >= 100) toRemove.push(index);
		}

		toRemove.reverse();
		foreach(index in toRemove)
		{
			ret.remove(index);
		}

		if ( this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("AttributesPlayer").getValue()) 	ret.extend(this.getTooltipAttributesSmall(100));
		if (!this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("AttributesNonPlayer").getValue()) 	ret.extend(this.getTooltipAttributesSmall(100));
		if ( this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("EffectsPlayer").getValue()) 		ret.extend(this.getTooltipEffects(200));
		if (!this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("EffectsNonPlayer").getValue()) 	ret.extend(this.getTooltipEffects(200));
		if ( this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("PerksPlayer").getValue()) 			ret.extend(this.getTooltipPerks(300));
		if (!this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("PerksNonPlayer").getValue()) 		ret.extend(this.getTooltipPerks(300));
		if ( this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("ItemsPlayer").getValue()) 			ret.extend(this.getTooltipItems(400));
		if (!this.isPlayerControlled() && ::Reforged.Mod.ModSettings.getSetting("ItemsNonPlayer").getValue()) 		ret.extend(this.getTooltipItems(400));
		ret.extend(this.getGroundItems(500));

		return ret;
	}

	local checkMorale = o.checkMorale;
	o.checkMorale = function( _change, _difficulty, _type = ::Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change < 0)
		{
			this.getCurrentProperties().MoraleCheckBravery[_type] += this.getCurrentProperties().NegativeMoraleCheckBravery[_type];
			this.getCurrentProperties().MoraleCheckBraveryMult[_type] *= this.getCurrentProperties().NegativeMoraleCheckBraveryMult[_type];
		}
		else if (_change > 0)
		{
			this.getCurrentProperties().MoraleCheckBravery[_type] += this.getCurrentProperties().PositiveMoraleCheckBravery[_type];
			this.getCurrentProperties().MoraleCheckBraveryMult[_type] *= this.getCurrentProperties().PositiveMoraleCheckBraveryMult[_type];
		}

		return checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}

	local getSurroundedCount = o.getSurroundedCount;
	o.getSurroundedCount = function()
	{
		local startSurroundCountAt = this.m.CurrentProperties.StartSurroundCountAt;
		this.m.CurrentProperties.StartSurroundCountAt = ::Const.CharacterProperties.StartSurroundCountAt;

		local count = getSurroundedCount();

		foreach (enemy in ::Tactical.Entities.getHostileActors(this.getFaction(), this.getTile(), 2, true))
		{
			local perk = enemy.getSkills().getSkillByID("perk.rf_long_reach");
			if (perk != null && perk.isEnabled())
			{
				count++;
			}
		}

		this.m.CurrentProperties.StartSurroundCountAt = startSurroundCountAt;

		return ::Math.max(0, count - startSurroundCountAt);
	}
});
