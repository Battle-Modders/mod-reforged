::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
	q.m.IsWaitingTurn <- false;		// Is only set true when using the new Wait-All button. While true this entity will try to use Wait when its their turn
	q.m.RF_DamageReceived <- null; // Table with faction number as key and tables as values. These tables have actor ID as key and the damage dealt as their value. Is populated during skill_container.onDamageReceived

	q.create = @(__original) function()
	{
		__original();
		this.m.RF_DamageReceived = { Total = 0.0 };
	}

	q.onInit = @(__original) function()
	{
		__original();
		this.getSkills().add(::new("scripts/skills/effects/rf_inspired_by_champion_effect"));
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

	q.getTooltip = @(__original) function( _targetedWithSkill = null )
	{
		local ret = __original(_targetedWithSkill);

		if (!this.isPlacedOnMap() || !this.isAlive() || this.isDying()) return ret;
		if (this.isDiscovered() == false) return ret;
		if (this.isHiddenToPlayer()) return ret;
		foreach (entry in ret)
		{
			if (entry.id == 4)
			{
				local text = entry.text;
				// The first word in vanilla is "Acts" or "Acting" and we want to add the word "again" after that to show that
				// this actor has used Wait. So we replace the first instance of space with "again" hyperlinked to Wait concept.
				if (this.m.IsActingEachTurn && !this.m.IsTurnDone && this.isWaitActionSpent())
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.String.replace(entry.text, " ", " [again|Concept.Wait] "));

				entry.text = "<div class = rf_tacticalTooltipWaitContainer>" + "[img]gfx/ui/icons/initiative.png[/img]" + text + "</div>";
				entry.rawHTMLInText <- true;
				delete entry.icon
				break;
			}
		}

		// Adjust existing progressbars displayed by Vanilla
		for (local index = (ret.len() - 1); index >= 0; index--)	// we move through it backwards to safely remove entries during it
		{
			local entry = ret[index];
			// Display the actual values for Armor (5, 6), Health (7) and Fatigue (9)
			if (entry.id == 5 || entry.id == 6 || entry.id == 7 || entry.id == 9)
			{
				entry.text = " " + entry.value + " / " + entry.valueMax;
			}

			// Insert reach information
			if (entry.id == 5)
			{
				ret.insert(index, ::Reforged.TacticalTooltip.getReach(this, 50));
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

		if (verifySettingValue("TacticalTooltip_Attributes")) ret.append(::Reforged.TacticalTooltip.getTooltipAttributesSmall(this, 100));
		if (verifySettingValue("TacticalTooltip_Effects")) ret.extend(::Reforged.TacticalTooltip.getTooltipEffects(this, 200));
		if (verifySettingValue("TacticalTooltip_Perks")) ret.extend(::Reforged.TacticalTooltip.getTooltipPerks(this, 300));
		if (verifySettingValue("TacticalTooltip_ActiveSkills")) ret.extend(::Reforged.TacticalTooltip.getActiveSkills(this, 400));
		if (verifySettingValue("TacticalTooltip_EquippedItems")) ret.extend(::Reforged.TacticalTooltip.getTooltipEquippedItems(this, 500));
		if (verifySettingValue("TacticalTooltip_BagItems")) ret.extend(::Reforged.TacticalTooltip.getTooltipBagItems(this, 600));

		ret.extend(::Reforged.TacticalTooltip.getGroundItems(this, 700));

		return ret;
	}

	q.checkMorale = @(__original) function( _change, _difficulty, _type = ::Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change < 0)
		{
			local p = this.getCurrentProperties();
			p.MoraleCheckBravery[_type] += p.NegativeMoraleCheckBravery[_type];
			p.MoraleCheckBraveryMult[_type] *= p.NegativeMoraleCheckBraveryMult[_type];
		}
		else if (_change > 0)
		{
			local p = this.getCurrentProperties();
			p.MoraleCheckBravery[_type] += p.PositiveMoraleCheckBravery[_type];
			p.MoraleCheckBraveryMult[_type] *= p.PositiveMoraleCheckBraveryMult[_type];
		}

		local ret = __original(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);

		// This is the most secure way to revert the changes to MoraleCheckBravery and MoraleCheckBraveryMult.
		// Reverting them manually has edge cases where you may or may not want to revert them depending on whether an update already happened.
		this.m.Skills.update();

		return ret;
	}

	q.onRoundStart = @(__original) function()
	{
		this.m.IsWaitingTurn = false;
		__original();
	}

	q.getSurroundedCount = @(__original) function()
	{
		// We need the honest un-clamped vanilla surround amount.
		// So we set StartSurroundCountAt to 0 and then additionally counter the manual -1, which vanilla does before calling 'max' and also set
		local startSurroundCountAt = this.m.CurrentProperties.StartSurroundCountAt;
		this.m.CurrentProperties.StartSurroundCountAt = -1;
		local count = __original();
		this.m.CurrentProperties.StartSurroundCountAt = startSurroundCountAt;

		local myTile = this.getTile();
		foreach (enemy in ::Tactical.Entities.getHostileActors(this.getFaction(), myTile, 2, true))
		{
			if (!enemy.hasZoneOfControl() || enemy.isNonCombatant() || !enemy.getTile().hasLineOfSightTo(myTile, enemy.getCurrentProperties().getVision()))
				continue;

			local perk = enemy.getSkills().getSkillByID("perk.rf_long_reach");
			if (perk == null || !perk.isEnabled())
				continue;

			foreach (skill in enemy.getSkills().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (perk.isSkillValid(skill) && skill.verifyTargetAndRange(myTile, enemy.getTile()))
				{
					count++;
					break;
				}
			}
		}

		return ::Math.max(0, count - 1 - startSurroundCountAt);
	}

	q.isTurnDone = @(__original) function()
	{
		if (::Tactical.getNavigator().isTravelling(this)) return false;		// Copy&Paste of check from vanilla
		return __original() || this.m.IsWaitingTurn;
	}

	// Overwrite vanilla function. The logic is the same as vanilla except the following changes:
	// Scale the strength of the morale checks with the ratio of the victim's XP value to my XP value.
	// Dying enemies only trigger positive morale check if the killer is null or belongs to my allied factions.
	q.onOtherActorDeath = @() function( _killer, _victim, _skill )
	{
		if (!this.m.IsAlive || this.m.IsDying || _victim.getXPValue() <= 1)
			return;

		// In Reforged we add this to scale the morale checks
		local xpRatioMult = _victim.getXPValue() / ::Math.maxf(1, this.getXPValue());

		if (_victim.getFaction() == this.getFaction() && _victim.getCurrentProperties().TargetAttractionMult >= 0.5 && this.getCurrentProperties().IsAffectedByDyingAllies)
		{
			local difficulty = ::Const.Morale.AllyKilledBaseDifficulty - _victim.getXPValue() * ::Const.Morale.AllyKilledXPMult * xpRatioMult + ::Math.pow(_victim.getTile().getDistanceTo(this.getTile()), ::Const.Morale.AllyKilledDistancePow);
			this.checkMorale(-1, difficulty, ::Const.MoraleCheckType.Default, "", true);
		}
		else if (this.getAlliedFactions().find(_victim.getFaction()) == null && (_killer == null || this.getAlliedFactions().find(_killer.getFaction()) != null))
		{
			local difficulty = ::Const.Morale.EnemyKilledBaseDifficulty + _victim.getXPValue() * ::Const.Morale.EnemyKilledXPMult * xpRatioMult - ::Math.pow(_victim.getTile().getDistanceTo(this.getTile()), ::Const.Morale.EnemyKilledDistancePow);

			if (_killer != null && _killer.isAlive() && _killer.getID() == this.getID())
			{
				difficulty += ::Const.Morale.EnemyKilledSelfBonus;
			}

			this.checkMorale(1, difficulty);
		}
	}

	// Overwrite vanilla function. The logic is the same as vanilla except the following changes:
	// Scale the strength of the morale checks with the ratio of the fleeing ally's XP value to my XP value.
	// Add Resolve based on the number of allies present on the map.
	q.onOtherActorFleeing = @() function( _actor )
	{
		if (!this.m.IsAlive || this.m.IsDying || !this.m.CurrentProperties.IsAffectedByFleeingAllies)
			return;

		// In Reforged we add this to scale the morale checks
		local xpRatioMult = _actor.getXPValue() / ::Math.maxf(1, this.getXPValue());

		local difficulty = ::Const.Morale.AllyFleeingBaseDifficulty - _actor.getXPValue() * ::Const.Morale.AllyFleeingXPMult * xpRatioMult + ::Math.pow(_actor.getTile().getDistanceTo(this.getTile()), ::Const.Morale.AllyFleeingDistancePow);

		foreach (i, faction in ::Tactical.Entities.getAllInstances())
		{
			if (this.isAlliedWith(i))
			{
				difficulty += faction.filter(@(_a) _a.getMoraleState() != ::Const.MoraleState.Fleeing).len() * ::Const.Morale.RF_AllyFleeingBraveryModifierPerAlly;
			}
		}
		// Remove the bonus from counting the actor himself which got added above
		difficulty -= ::Const.Morale.RF_AllyFleeingBraveryModifierPerAlly;

		this.checkMorale(-1, difficulty);
	}

// New Functions:
	q.getSurroundedBonus <- function( _targetEntity )
	{
		local surroundedCount = _targetEntity.getSurroundedCount();
		local surroundBonus = surroundedCount * this.getCurrentProperties().SurroundedBonus * this.getCurrentProperties().SurroundedBonusMult;
		surroundBonus -= surroundedCount * _targetEntity.getCurrentProperties().SurroundedDefense;
		return surroundBonus;
	}

	q.setWaitTurn <- function( _bool )
	{
		this.m.IsWaitingTurn = _bool;
	}
});

::Reforged.HooksMod.hookTree("scripts/entity/tactical/actor", function(q) {
	q.onActorKilled = @(__original) function( _actor, _tile, _skill )
	{
		local wasOverriding = ::Reforged.Config.XPOverride;
		::Reforged.Config.XPOverride = true;
		__original(_actor, _tile, _skill);
		::Reforged.Config.XPOverride = wasOverriding;
	}

	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		__original(_killer, _skill, _tile, _fatalityType);

		// The following is an override of the XP gain system. We award XP based on ratio of total damage dealt to an entity.

		// - All factions who did damage share the XP gained from this actor's death.
		// - The XP available to a faction is based on the percentage of total damage done by this faction.
		// - This is divided into Killer XP and Group XP.
		// - The brothers who did damage are considered "Killers". They share the Killer XP based on the
		// percentage of damage done by each bro relative to other bros who did damage.
		// - The group XP is then shared equally among all bros in the company.

		local bros = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);

		if (::Const.Faction.Player in this.m.RF_DamageReceived)
		{
			local XPavailable = this.getXPValue() * this.m.RF_DamageReceived[::Const.Faction.Player].Total / this.m.RF_DamageReceived.Total;
			local XPkiller = XPavailable * ::Const.XP.XPForKillerPct; // This will be divided among all bros who did damage. The rest will be divided equally among other bros.
			local XPgroup = ::Math.max(1, ::Math.floor((XPavailable - XPkiller) / bros.len()));
			local brosDamage = this.m.RF_DamageReceived[::Const.Faction.Player];

			foreach (bro in bros)
			{
				if (bro.getID() in brosDamage)
				{
					bro.addXP(::Math.max(1, ::Math.round(XPkiller * brosDamage[bro.getID()] / brosDamage.Total))); // We use Math.round vs vanilla Math.floor so that the XPkiller is fully used instead of missing 1-2 xp
				}

				if (!bro.getCurrentProperties().IsAllyXPBlocked)
				{
					bro.addXP(XPgroup);
				}
			}
		}

		if (::Const.Faction.PlayerAnimals in this.m.RF_DamageReceived)
		{
			local XPgroup = (this.getXPValue() * this.m.RF_DamageReceived[::Const.Faction.PlayerAnimals].Total / this.m.RF_DamageReceived.Total) * (1.0 - ::Const.XP.XPForKillerPct);
			XPgroup = ::Math.max(1, ::Math.floor(XPgroup / bros.len()));

			foreach (bro in bros)
			{
				if (!bro.getCurrentProperties().IsAllyXPBlocked)
					bro.addXP(XPgroup);
			}
		}
	}
});
