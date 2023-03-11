::mods_hookExactClass("entity/tactical/actor", function(o) {
	o.m.IsPerformingAttackOfOpportunity <- false;

	o.isDisarmed <- function()
	{
		local handToHand = this.getSkills().getSkillByID("actives.hand_to_hand");
		return handToHand != null && handToHand.isUsable();
	}

	// Complete overwrite of vanilla function to fix bug where buffs to fatigue also buff initiative for the same amount
	o.getInitiative = function()
	{
		local initiative = this.getCurrentProperties().getInitiative();
		initiative -= this.getFatigue() * this.getCurrentProperties().FatigueToInitiativeRate;	// Subtract Accumulated Fatigue from Initiative
		initiative += ::Math.min(0, this.getInitiativeModifier());					// Subtract Burden from Initiative
		return ::Math.floor(initiative);	// Vanilla does a round here but I argue that a consistent use of floor is better overall
	}

	// Items no longer apply their Fatigue Penalty directly. This is now only done when calling this function
	// This rewrite also fixes the issue where StaminaMult was based of the stamina after gear. Now it only affects the stamina before gear
	o.getFatigueMax = function()
	{
		local stamina = this.getCurrentProperties().getStamina();
		return ::Math.floor(::Math.max(0, stamina + this.getStaminaModifier()));
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
		this.getSkills().add(::new("scripts/skills/special/rf_weapon_mastery_standardization"));

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

		// Adjust existing progressbars displayed by Vanilla
		for (local index = (ret.len() - 1); index >= 0; index--)	// we move through it backwards to safely remove entries during it
		{
			local entry = ret[index];
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
			if (entry.id >= 100) ret.remove(index);
		}

		local function verifySettingValue( _settingID )
		{
			local value = ::Reforged.Mod.ModSettings.getSetting(_settingID).getValue();
			return value != "None" && (value == "All" || (value == "Player Only" && this.isPlayerControlled()) || (value == "AI Only" && !this.isPlayerControlled()))
		}

		if (verifySettingValue("TacticalTooltip_Attributes")) ret.extend(::Reforged.TacticalTooltip.getTooltipAttributesSmall(this, 100));
		if (verifySettingValue("TacticalTooltip_Effects")) ret.extend(::Reforged.TacticalTooltip.getTooltipEffects(this, 200));
		if (verifySettingValue("TacticalTooltip_Perks")) ret.extend(::Reforged.TacticalTooltip.getTooltipPerks(this, 300));
		if (verifySettingValue("TacticalTooltip_EquippedItems")) ret.extend(::Reforged.TacticalTooltip.getTooltipEquippedItems(this, 400));
		if (verifySettingValue("TacticalTooltip_BagItems")) ret.extend(::Reforged.TacticalTooltip.getTooltipBagItems(this, 400));

		ret.extend(::Reforged.TacticalTooltip.getGroundItems(this, 500));

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

// New Functions
	// Returns the fatigue penalty inflicted onto the actor by all the items they wear (also known as [current] Weight)
	// During onUpdateProperties this may not be correct if called with SkillOrder.Perk or below (Brawny and BagsAndBelts influence this)
	o.getStaminaModifier <- function( _slots = null )
	{
		if (_slots == null)
		{
			 _slots = clone ::Const.ItemSlot;
			 delete _slots.None;
			 delete _slots.Free;
			 delete _slots.COUNT;
		}
		else
		{
			if (typeof _slots == "integer") _slots = [_slots];
		}

		local ret = 0;

		foreach (slot in _slots)
		{
			ret += this.getItems().getStaminaModifier(slot) * this.getCurrentProperties().StaminaModifierMult[slot];
		}

		return ret;
	}

	// Returns the current initiative penalty inflicted onto the actor by all the items they wear (also known as Burden)
	// During onUpdateProperties this may not be correct if called with SkillOrder.Perk or below (Brawny, Skirmisher and BagsAndBelts influence this)
	o.getInitiativeModifier <- function( _slots = null )
	{
		if (_slots == null)
		{
			 _slots = clone ::Const.ItemSlot;
			 delete _slots.None;
			 delete _slots.Free;
			 delete _slots.COUNT;
		}
		else
		{
			if (typeof _slots == "integer") _slots = [_slots];
		}

		local ret = 0;

		foreach (slot in _slots)
		{
			ret += this.getStaminaModifier(slot) * this.getCurrentProperties().InitiativeModifierMult[slot];
		}

		return ret;
	}
});
