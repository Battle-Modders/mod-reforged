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

			// Remove all vanilla generated effect entries
			if (entry.id >= 100) toRemove.push(index);
		}

		toRemove.reverse();
		foreach(index in toRemove)
		{
			ret.remove(index);
		}

		// ret.extend(this.getTooltipAttributes(100));
		ret.extend(this.getTooltipAttributesSmall(100));
		ret.extend(this.getTooltipEffects(200));
		ret.extend(this.getTooltipPerks(300));
		ret.extend(this.getTooltipItems(400));

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

	// Returns a list of all attributes in tooltip-form which are not displayed as progressbars on the tooltips
	// Those are Melee/Ranged Skill/Defense, Resolve and Initiative
	o.getTooltipAttributesSmall <- function( _startID )
	{
		local gapLength = 6;
		local attributeList = [];
		// this.pushSectionName(attributeList, "Attributes", _startID);

		local meleeSkillText = 		this.getAttributeEntry("melee_skill_15px.png", this.getCurrentProperties().getMeleeSkill(), this.getCurrentProperties().getMeleeSkill() - this.getBaseProperties().getMeleeSkill());
		local meleeDefenseText = 	this.getAttributeEntry("melee_defense_15px.png", this.getCurrentProperties().getMeleeDefense(), this.getCurrentProperties().getMeleeDefense() - this.getBaseProperties().getMeleeDefense());
		local rangedSkillText = 	this.getAttributeEntry("ranged_skill_15px.png", this.getCurrentProperties().getRangedSkill(), this.getCurrentProperties().getRangedSkill() - this.getBaseProperties().getRangedSkill());
		local rangedDefenseText = 	this.getAttributeEntry("ranged_defense_15px.png", this.getCurrentProperties().getRangedDefense(), this.getCurrentProperties().getRangedDefense() - this.getBaseProperties().getRangedDefense());
		local resolveText = 		this.getAttributeEntry("bravery_15px.png", this.getCurrentProperties().getBravery(), this.getCurrentProperties().getBravery() - this.getBaseProperties().getBravery());
		local initiativeText = 		this.getAttributeEntry("initiative_15px.png", this.getInitiative(), this.getInitiative() - this.getBaseProperties().getInitiative());

		local meleeSkill = "" + this.getCurrentProperties().getMeleeSkill();
		local meleeDefense = "" + this.getCurrentProperties().getMeleeDefense();
		local firstRow = meleeSkillText + this.getSpacebars(gapLength - (meleeSkill.len() * 2)) + meleeDefenseText + this.getSpacebars(gapLength - (meleeDefense.len() * 2)) + resolveText;
		local currentID = _startID + 1;
		attributeList.push({
			id = currentID,
			type = "text",
			text = firstRow
		});

		local rangedSkill = "" + this.getCurrentProperties().getRangedSkill();
		local rangedDefense = "" + this.getCurrentProperties().getRangedDefense();
		local secondRow = rangedSkillText + this.getSpacebars(gapLength - (rangedSkill.len() * 2)) + rangedDefenseText + this.getSpacebars(gapLength - (rangedDefense.len() * 2)) + initiativeText;
		currentID++;
		attributeList.push({
			id = currentID,
			type = "text",
			text = secondRow
		});

		return attributeList;
	}

	o.getSpacebars <- function( _amount )
	{
		local ret = "";
		for (local i = 0; i < _amount; i++)
		{
			ret += "&nbsp;";
		}
		return ret;
	}

	o.getAttributeEntry <- function( _icon, _currentValue, _difference )
	{
		local bracketsTextSize = 10;
		local entryText = "[img]gfx/ui/icons/" + _icon + "[/img] " + _currentValue;
		if (_difference != 0) entryText += "[size=" + bracketsTextSize + "] (" + ::MSU.Text.colorizeValue(_difference) + ")[/size]";
		return entryText;
	}

	// Returns a list of all important items in tooltip-form which
	o.getTooltipItems <- function( _startID )
	{
		local currentID = _startID;
		local itemList = [];

		this.pushSectionName(itemList, "Equipped Items", currentID);
		currentID++;
		local mainhandItems = this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Mainhand);
		foreach(mainhandItem in mainhandItems)
		{
			itemList.push({
				id = currentID,
				type = "text",
				icon = "ui/items/" + mainhandItem.getIcon(),
				text = mainhandItem.getName()
			});
			currentID++;
		}
		local offhandItems = this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Offhand);
		foreach(offhandItem in offhandItems)
		{
			itemList.push({
				id = currentID,
				type = "text",
				icon = "ui/items/" + offhandItem.getIcon(),
				text = offhandItem.getName()
			});
			currentID++;
		}
		local accessories = this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Accessory);
		foreach(accessory in accessories)
		{
			itemList.push({
				id = currentID,
				type = "text",
				icon = "ui/items/" + accessory.getIcon(),
				text = accessory.getName()
			});
			currentID++;
		}

		this.pushSectionName(itemList, "Items in bag", currentID);
		currentID++;
		local bagItems = this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
		foreach(bagItem in bagItems)
		{
			itemList.push({
				id = currentID,
				type = "text",
				icon = "ui/items/" + bagItem.getIcon(),
				text = bagItem.getName()
			});
			currentID++;
		}

		local groundItems = this.getTile().Items;
		if (bagItems.len() != 0)
		{
			this.pushSectionName(itemList, "Items on ground", currentID);
			currentID++;
			foreach(groundItem in groundItems)
			{
				itemList.push({
					id = currentID,
					type = "text",
					icon = "ui/items/" + groundItem.getIcon(),
					text = groundItem.getName()
				});
				currentID++;
			}
		}

		return itemList;
	}


	// Returns a list of all effects in tooltip-form
	o.getTooltipEffects <- function( _startID )
	{
		local effectList = [];
		this.pushSectionName(effectList, "Effects", _startID);

		local statusEffects = this.getSkills().query(::Const.SkillType.StatusEffect, false, true);
		foreach( i, statusEffect in statusEffects )
		{
			if (statusEffect.m.EffectHiddenInTacticalTooltip) continue;

			local effect = {
				id = _startID + i + 1,
				type = "text",
				icon = statusEffect.getIcon(),
				text = statusEffect.getName()
			};

			/*
			if (statusEffect.isType(::Const.SkillType.Injury))	// Injuries additionally display their effects is child-tooltips
			{
				local injuryEffects = statusEffect.getTooltip().filter(function ( _, row )
				{
					return (("type" in row) && row.type == "text");
				});

				local addedTooltipHints = [];	// getTooltip() adds more lines of text which we need to filter out now
				statusEffect.addTooltipHint(addedTooltipHints);
				addedTooltipHints = addedTooltipHints.filter(function ( _, row )
				{
					return (("type" in row) && row.type == "text");
				});
				local added_count = addedTooltipHints.len();

				if (added_count)
				{
					injuryEffects.resize(injuryEffects.len() - added_count);
				}

				local isUnderIronWill = function ()
				{
					local pattern = this.regexp("Iron Will");

					foreach( _, row in addedTooltipHints )
					{
						if (("text" in row) && pattern.search(row.text))
						{
							return true;
						}
					}

					return false;
				}();

				if (isUnderIronWill)
				{
					effect.text += "[color=" + this.Const.UI.Color.PositiveValue + "]" + " (Iron Will)[/color]";
				}
				else
				{
					effect.children <- injuryEffects;
				}
			}*/

			effectList.push(effect);
		}

		return effectList;
	}

	// Returns a list of all perks in tooltip-form
	o.getTooltipPerks <- function( _startID )
	{
		local collapseThreshold = 7;

		local perkList = [];
		this.pushSectionName(perkList, "Perks", _startID);

		local perks = this.getSkills().query(::Const.SkillType.Perk, true, true);
		if (perks.len() < collapseThreshold)
		{
			foreach( i, perk in perks )
			{
				local perkEntry = {
					id = _startID + i + 1,
					type = "text",
					icon = perk.getIcon(),
					text = perk.getName()
				};

				perkList.push(perkEntry);
			}
		}
		else
		{
			local entryText = "";
			foreach( perk in perks )
			{
				entryText += perk.getName();
				entryText += ", ";
			}
			entryText = entryText.slice(0, -2);		// entryText can never be empty because we are guaranteed to have #collapseThreshold amount of perks

			perkList.push({
				id = _startID + 1,
				type = "text",
				text = entryText
			});
		}

		return perkList;
	}

	o.pushSectionName <- function ( _list, _title, _startID )
	{
		_list.push({
			id = _startID,
			type = "text",
			text = "[u][size=14]" + _title + "[/size][/u]"
		});
	};

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
