::Reforged.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
	// Add info about potential attacks of opportunity during movement preview
	q.tactical_queryTileTooltipData = @(__original) { function tactical_queryTileTooltipData()
	{
		local ret = __original();
		if (ret == null)
			return ret;

		local lastTileHovered = ::Tactical.State.getLastTileHovered();

		// Only for the tile the player marked as movement target (vanilla computeEntityPath)
		local targetTile = ::Tactical.State.m.LastTileSelected;
		if (lastTileHovered.IsEmpty && ::Tactical.State.getCurrentActionState() == ::Const.Tactical.ActionState.ComputePath && targetTile != null && targetTile.ID == lastTileHovered.ID)
		{
			ret.extend(this.RF_getMovementPreviewTooltip(::Tactical.TurnSequenceBar.getActiveEntity()));
		}

		if (!lastTileHovered.IsOccupiedByActor && lastTileHovered.Items != null)
		{
			foreach (entry in ret)
			{
				if ("useItemPath" in entry && entry.type == "icons")
				{
					entry.icons = lastTileHovered.Items.map(@(_item) ::Reforged.Mod.Tooltips.parseString(format("[Img/gfx/ui/items/%s|Obj+%s,contentType:ui-item]", _item.getIcon(), ::Reforged.Mod.Tooltips.parseObject(_item))));
					break;
				}
			}
		}
		return ret;
	}}.tactical_queryTileTooltipData;

	q.general_queryUIElementTooltipData = @(__original) { function general_queryUIElementTooltipData( _entityId, _elementId, _elementOwner )
	{
		// Overwrites
		switch (_elementId)
		{
			case "character-screen.left-panel-header-module.Experience":
				return [
					{
						id = 1,
						type = "title",
						text = "Experience"
					},
					{
						id = 2,
						type = "description",
						text = ::Reforged.Mod.Tooltips.parseString("Characters gain experience in battle and if a character has accumulated sufficient experience, he\'ll [level up|Concept.Level].\n\nExperience is gained upon an enemy\'s death, no matter what caused the death, as long as your company dealt some damage to that enemy, and is proportional to the fraction of the total damage dealt to that enemy by your company. Of this experience, " + (::Const.XP.XPForKillerPct * 100) + "% is shared proportionally between the brothers who did damage. The other " + (100 - ::Const.XP.XPForKillerPct * 100) + "% is shared equally among all members of the company.")
					}
				];

			case "character-screen.left-panel-header-module.Level":
				local veteranPerksText = ::Reforged.Config.VeteranPerksLevelStep == 0 ? "no longer gain perk points" : format("gain perk points every %s", ::Reforged.Config.VeteranPerksLevelStep == 1 ? "level" : ::Reforged.Config.VeteranPerksLevelStep + " levels");
				return [
					{
						id = 1,
						type = "title",
						text = "Level"
					},
					{
						id = 2,
						type = "description",
						text = ::Reforged.Mod.Tooltips.parseString("A character\'s level measures [experience|Concept.Experience] in battle. Characters rise in levels as they gain experience and are able to increase their [attributes|Concept.CharacterAttribute] and gain [perks|Concept.Perk] that make them better at the mercenary profession.\n\nBeyond the " + ::Const.XP.MaxLevelWithPerkpoints + "th level, characters are veterans and " + veteranPerksText + ". They can still improve their attributes but the attribute gain per level is small.")
					}
				];
		}

		// Extending
		local ret = __original(_entityId, _elementId, _elementOwner);

		if (ret != null)
		{
			switch (_elementId)
			{
				case "character-stats.Bravery":
					foreach (entry in ret)
					{
						if (entry.id == 2 && entry.type == "description")
						{
							entry.text = ::String.replace(entry.text, "See also: Morale.", ::Reforged.Mod.Tooltips.parseString("See also: [Morale|Concept.Morale]."));
							break;
						}
					}
					break;

				case "character-stats.MeleeDefense":
				case "character-stats.RangeDefense":
					if (::Const.Tactical.Settings.AttributeDefenseSoftCap != 0)
					{
						foreach (entry in ret)
						{
							if (entry.id == 2 && entry.type == "description")
							{
								entry.text += ::Reforged.Mod.Tooltips.parseString("\n\nEach point of [current|Concept.CurrentAttribute] defense above " + ::Const.Tactical.Settings.AttributeDefenseSoftCap + " counts as half a point.");
								break;
							}
						}
					}
					break;
			}

			ret.extend(this.getBaseAttributesTooltip(_entityId, _elementId, _elementOwner));
		}

		return ret;
	}}.general_queryUIElementTooltipData;

// New Functions
	// Adds entries to the tile tooltip during movement preview, calculated by ::Reforged.HitchanceOverlay:
	// - attacks on movement and on arrival (zone of control): always, or like the hit chances below
	//   (setting HitchanceDisplay_ZOCAttacks, see HitchanceOverlay.isZOCAlwaysShown);
	// - predicted chances to hit and to be hit at the destination, when the display mode includes the tooltip.
	q.RF_getMovementPreviewTooltip <- { function RF_getMovementPreviewTooltip( _entity )
	{
		if (_entity == null || !_entity.isPlacedOnMap() || !_entity.isPlayerControlled())
			return [];

		local overlay = ::Reforged.HitchanceOverlay;
		local isHitchanceShown = overlay.isTooltipShown();
		local isZOCShown = overlay.isZOCAlwaysShown() || (isHitchanceShown && overlay.getShowFlags().Enemy);
		if (!isHitchanceShown && !isZOCShown)
			return [];

		local snapshot = overlay.computeMovementPreview(_entity, !isHitchanceShown);
		if (snapshot == null)
			return [];

		local ret = [];
		if (isZOCShown)
			ret.extend(this.RF_getZOCAttacksTooltip(snapshot));

		if (!isHitchanceShown)
			return ret;

		// Chances to hit valid targets and to be hit from opponents assuming we are at the destination tile
		local subjectExtraData = "entityId:" + _entity.getID();
		local collapseThreshold = ::Reforged.Mod.ModSettings.getSetting("HitchanceDisplay_CollapseThreshold").getValue();
		local attacks = [];
		local attacksBelowThreshold = "";

		foreach (entry in snapshot.Entries)
		{
			local enemy = ::Tactical.getEntityByID(entry.ID);
			if (enemy == null)
				continue;

			if (entry.ToHit == null && entry.ToBeHit == null)
				continue;

			if (entry.ToHit == null && entry.ToBeHit <= collapseThreshold)
			{
				attacksBelowThreshold += ::Reforged.NestedTooltips.getNestedEntityImage(enemy);
				continue;
			}

			local text = "";
			local score = 0;
			if (entry.ToHit != null && !::MSU.isNull(entry.ToHitSkill))
			{
				score = 1000 + entry.ToHit;
				text = format("%s with %s", ::MSU.Text.colorPositive(entry.ToHit + "%"), ::Reforged.NestedTooltips.getNestedSkillName(entry.ToHitSkill.get(), subjectExtraData));
			}

			if (entry.ToBeHit != null && !::MSU.isNull(entry.ToBeHitSkill))
			{
				score += entry.ToBeHit;
				text += text == "" ? "" : ", ";
				text += format("%s with %s%s", ::MSU.Text.colorNegative(entry.ToBeHit + "%"), ::Reforged.NestedTooltips.getNestedSkillName(entry.ToBeHitSkill.get(), "entityId:" + enemy.getID()), overlay.getNextTurnSuffix(enemy));
			}

			if (text == "")
				continue;

			attacks.push([score, {
				id = 100, type = "text", icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedEntityImage(enemy)),
				text = ::Reforged.Mod.Tooltips.parseString(text)
			}]);
		}

		if (attacks.len() != 0)
		{
			ret.push({
				id = 100, type = "text", icon = "ui/icons/icon_contract_swords.png",
				text = format("Chances %s and %s:", ::MSU.Text.colorPositive("to hit"), ::MSU.Text.colorNegative("to be hit"))
			})
			attacks.sort(@(_a, _b) -1 * (_a[0] <=> _b[0]));
			ret.extend(attacks.map(@(_a) _a[1]));
		}

		if (attacksBelowThreshold != "")
		{
			ret.push({
				id = 100, type = "text", icon = "ui/icons/icon_contract_swords.png",
				text = "Opponents with a hit chance of " + ::MSU.Text.colorNegative(collapseThreshold + "%") + " or less"
				children = [{ id = 100, type = "text", text = ::Reforged.Mod.Tooltips.parseString(attacksBelowThreshold) }]
			});
		}

		return ret;
	}}.RF_getMovementPreviewTooltip;

	// Tooltip entries for the attacks on movement (zone of control at the starting tile) and on arrival
	// (e.g. Spearwall at the ending tile) in _snapshot (see ::Reforged.HitchanceOverlay.compute)
	q.RF_getZOCAttacksTooltip <- { function RF_getZOCAttacksTooltip( _snapshot )
	{
		local function getAttackEntry( _actor, _attack )
		{
			return {
				id = 100,	type = "text",	icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedEntityImage(_actor)),
				text = ::MSU.Text.colorNegative(_attack.Hitchance + "%") + " chance to hit with " + ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedSkillName(_attack.Skill.get(), "entityId:" + _actor.getID()))
			};
		}

		local leaveAttacks = [];
		local arriveAttacks = [];
		foreach (entry in _snapshot.Entries)
		{
			local actor = ::Tactical.getEntityByID(entry.ID);
			if (actor == null)
				continue;
			if (entry.LeaveAttack != null && !::MSU.isNull(entry.LeaveAttack.Skill))
				leaveAttacks.push(getAttackEntry(actor, entry.LeaveAttack));
			if (entry.ArriveAttack != null && !::MSU.isNull(entry.ArriveAttack.Skill))
				arriveAttacks.push(getAttackEntry(actor, entry.ArriveAttack));
		}

		local ret = [];
		if (leaveAttacks.len() != 0)
		{
			ret.push({
				id = 100,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will be [attacked on movement|Concept.ZoneOfControl] by:"),
				children = leaveAttacks
			});

			if (_snapshot.ZOCFatigue != 0)
			{
				ret.push({
					id = 100,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = ::Reforged.Mod.Tooltips.parseString("Evading these attacks builds " + ::MSU.Text.colorizeValue(_snapshot.ZOCFatigue, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
				});
			}
		}

		if (arriveAttacks.len() != 0)
		{
			ret.push({
				id = 101,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("Will be attacked on arrival by:"),
				children = arriveAttacks
			});
		}

		return ret;
	}}.RF_getZOCAttacksTooltip;

	q.getBaseAttributesTooltip <- { function getBaseAttributesTooltip( _entityId, _elementId, _elementOwner )
	{
		local entity = _entityId == null ? null : ::Tactical.getEntityByID(_entityId);
		if (entity == null || entity == ::MSU.getDummyPlayer())
		{
			return [];
		}

		local baseValue, currentValue, icon, extra;

		// Manually look for all attribute IDs and generate the respective tooltip entries
		switch (_elementId)
		{
			case "character-stats.MeleeSkill":
				baseValue = entity.getBaseProperties().getMeleeSkill();
				currentValue = entity.getCurrentProperties().getMeleeSkill();
				icon = "/ui/icons/melee_skill.png";
				break;

			case "character-stats.RangeSkill":
				baseValue = entity.getBaseProperties().getRangedSkill();
				currentValue = entity.getCurrentProperties().getRangedSkill();
				icon = "/ui/icons/ranged_skill.png";
				break;

			case "character-stats.MeleeDefense":
				baseValue = entity.getBaseProperties().getMeleeDefense();
				currentValue = entity.getCurrentProperties().getMeleeDefense();
				icon = "/ui/icons/melee_defense.png";
				break;

			case "character-stats.RangeDefense":
				baseValue = entity.getBaseProperties().getRangedDefense();
				currentValue = entity.getCurrentProperties().getRangedDefense();
				icon = "/ui/icons/ranged_defense.png";
				break;

			case "character-stats.Bravery":
				baseValue = entity.getBaseProperties().getBravery();
				currentValue = entity.getCurrentProperties().getBravery();
				icon = "/ui/icons/bravery.png";
				break;

			case "character-stats.Initiative":
				// For base, can't use entity.getInitiative() with switcheroo on CurrentProperties
				// because that function subtracts using m.Fatigue.
				baseValue = entity.getBaseProperties().getInitiative();
				// For current, use entity.getInitiative() instead of CurrentProperties.getInitiative()
				// because the entity function is the one that applies reduction based on built Fatigue.
				currentValue = entity.getInitiative();
				icon = "/ui/icons/initiative.png";
				break;

			case "character-stats.Hitpoints":
				// Switcheroo CurrentProperties to BaseProperties to get base value because entity.getHitpointsMax() uses CurrentProperties
				local c = entity.getCurrentProperties();
				entity.m.CurrentProperties = entity.getBaseProperties();
				baseValue = entity.getHitpointsMax();
				entity.m.CurrentProperties = c;
				currentValue = entity.getHitpointsMax();
				icon = "ui/icons/health.png";
				break;

			case "character-stats.Fatigue":
				// Switcheroo CurrentProperties to BaseProperties to get base value because entity.getFatigueMax() uses CurrentProperties
				local c = entity.getCurrentProperties();
				entity.m.CurrentProperties = entity.getBaseProperties();
				baseValue = entity.getFatigueMax();
				entity.m.CurrentProperties = c;
				currentValue = entity.getFatigueMax();
				icon = "ui/icons/fatigue.png";
				extra = [
					{
						id = 5,
						type = "text",
						icon = icon,
						text = "Fatigue Recovery: " + ::MSU.Text.colorizeValue(c.getFatigueRecoveryRate(), {AddSign = true})
					},
					{
						id = 6,
						type = "text",
						icon = "ui/icons/bag.png",
						text = "Item Weight: " + ::MSU.Text.colorNegative(::Math.abs(-1 * entity.getItems().getStaminaModifier()))
					}
				];
				break;

			case "Concept.Reach":
				baseValue = entity.getBaseProperties().getReach();
				currentValue = entity.getCurrentProperties().getReach();
				icon = "ui/icons/rf_reach.png";
				extra = [
					{
						id = 5,	type = "text",	icon = "ui/icons/rf_reach_attack.png",
						text = ::Reforged.Mod.Tooltips.parseString("[Ignore when attacking|Concept.ReachIgnoreOffensive]: ") + ::MSU.Text.colorizeValue(entity.getCurrentProperties().OffensiveReachIgnore)
					},
					{
						id = 6,	type = "text",	icon = "ui/icons/rf_reach_defense.png",
						text = ::Reforged.Mod.Tooltips.parseString("[Ignore when defending|Concept.ReachIgnoreDefensive]: ") + ::MSU.Text.colorizeValue(entity.getCurrentProperties().DefensiveReachIgnore)
					}
				];
				break;
		}

		if (baseValue == null)
			return [];

		local ret = [
			{
				id = 3,	type = "text",	icon = icon,
				text = "Base: " + ::MSU.Text.colorizeValue(baseValue, {AddSign = baseValue < 0})
			},
			{
				id = 4,	type = "text",	icon = icon,
				text = "Modifier: " + ::MSU.Text.colorizeValue(currentValue - baseValue, {AddSign = true})
			}
		];

		if (extra != null)
		{
			ret.extend(extra);
		}

		return ret;
	}}.getBaseAttributesTooltip;
});
