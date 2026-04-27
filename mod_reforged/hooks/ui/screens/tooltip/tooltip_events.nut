::Reforged.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
	// Add info about potential attacks of opportunity during movement preview
	q.tactical_queryTileTooltipData = @(__original) { function tactical_queryTileTooltipData()
	{
		local ret = __original();
		if (ret != null && ::Tactical.State.getLastTileHovered().IsEmpty && ::Tactical.State.getCurrentActionState() == ::Const.Tactical.ActionState.ComputePath)
		{
			ret.extend(this.RF_getHitchancesForMovementPreview(::Tactical.TurnSequenceBar.getActiveEntity()));
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
								entry.text += ::Reforged.Mod.Tooltips.parseString(" Each point of [current|Concept.CurrentAttribute] defense above " + ::Const.Tactical.Settings.AttributeDefenseSoftCap + " counts as half a point.");
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
	// Adds entries to the tile tooltip about zone of control attacks at the starting and ending tiles of the previewed movement
	q.RF_getHitchancesForMovementPreview <- { function RF_getHitchancesForMovementPreview( _entity )
	{
		if (_entity == null || !_entity.isPlacedOnMap())
			return [];

		local ret = [];

		// Add tooltip about zone of control attacks at the starting tile
		if (!_entity.getCurrentProperties().IsImmuneToZoneOfControl && (_entity.getTile().Properties.Effect == null || _entity.getTile().Properties.Effect.Type != "smoke"))
		{
			local attacks = ::Tactical.Entities.getAdjacentActors(_entity.getTile()).filter(@(_, _a) !_a.isAlliedWith(_entity) && _a.onMovementInZoneOfControl(_entity, false))
							.map(function(_a) {
								local aoo = _a.getSkills().getAttackOfOpportunity();
								return {
									id = 100,	type = "text",	icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedEntityImage(_a)),
									text = ::MSU.Text.colorNegative(aoo.getHitchance(_entity) + "%") + " chance to hit with " + ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedSkillName(aoo, "entityId:" + _a.getID()))
								}
							});

			if (attacks.len() != 0)
			{
				ret.push({
					id = 100,
					type = "text",
					icon = "ui/icons/warning.png",
					text = ::Reforged.Mod.Tooltips.parseString("Will be [attacked on movement|Concept.ZoneOfControl] by:"),
					children = attacks
				});

				local fatigueToDodgeAOO = _entity.RF_getZOCEvasionFatigue();
				if (fatigueToDodgeAOO != 0)
				{
					ret.push({
						id = 100,
						type = "text",
						icon = "ui/icons/fatigue.png",
						text = ::Reforged.Mod.Tooltips.parseString("Evading these attacks builds " + ::MSU.Text.colorizeValue(fatigueToDodgeAOO, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
					});
				}
			}
		}

		// _entity.getPreviewMovement is null when movement cannot be afforded at all
		if (_entity.getPreviewMovement() != null)
		{
			ret.extend(_entity.getSkills().MV_runBetweenPreviewUpdates(this.RF_getHitchancesAtDestination, this, this.RF_applyMovementPreview(_entity), this.RF_cleanupMovementPreview));
		}

		return ret;
	}}.RF_getHitchancesForMovementPreview;

	// Change and switcheroo various things so that the hit-chance calculations
	// are done as if the previewing entity is already on the previewed tile.
	q.RF_applyMovementPreview <- { function RF_applyMovementPreview( _entity )
	{
		local currTile = _entity.getTile();
		local destTile = ::Tactical.State.getLastTileHovered();

		// Switcheroo the entity's getTile function to return the currently hovered tile
		// so that hitchances of enemies are calculated with that. E.g. in case any skill
		// on the enemies wants to check distance to the target in its onAnySkillUsed function.
		// Similarly, height advantage etc. is properly accounted for.
		local original_getTile = _entity.getTile;
		_entity.getTile = @() destTile;

		// Goal:
		// - Consider the destination tile as occupied by the previewing entity.
		// - Consider destination tile and its neighbors part of ZoC of the previewing entity.
		// This is achieved by hooking the relevant functions of TacticalTile class and checking
		// for these specific data in the tile's Properties.
		// This is important so that any skill.isUsable checks or hit-chances or skill effects
		// behave more accurately when predicting during the preview.
		destTile.Properties.set("RF_PreviewEntity", _entity);
		if (_entity.hasZoneOfControl())
		{
			local f = _entity.getFaction();
			destTile.Properties.set("RF_PreviewZOCFaction", f);
			foreach (t in ::MSU.Tile.getNeighbors(destTile))
			{
				t.Properties.set("RF_PreviewZOCFaction", f);
			}
		}

		// Remove the current terrain effect from the previewing entity and add the
		// terrain effect of the destination tile. This ensures that hit-chances are
		// properly calculated based on the effects of the terrain.
		// We make this addition directly into the `m.Skills` of the skills container
		// instead of doing `container.add` because we don't want to *actually* add or remove
		// the terrain effects and don't want to trigger their `onAdded` or `onRemoved`.
		local currTerrainEffect, currTerrainEffectIdx;
		if (::Const.Tactical.TerrainEffect[currTile.Type].len() > 0)
		{
			local id = ::Const.Tactical.TerrainEffectID[currTile.Type];
			foreach (i, s in _entity.getSkills().m.Skills)
			{
				if (s.getID() == id)
				{
					currTerrainEffectIdx = i;
					currTerrainEffect = _entity.getSkills().m.Skills.remove(i);
					break;
				}
			}
		}

		local destTerrainEffect;
		if (::Const.Tactical.TerrainEffect[destTile.Type].len() > 0 && !_entity.getSkills().hasSkill(::Const.Tactical.TerrainEffectID[destTile.Type]))
		{
			destTerrainEffect = ::new(::Const.Tactical.TerrainEffect[destTile.Type]);
			destTerrainEffect.saveBaseValues();
			_entity.getSkills().m.Skills.push(destTerrainEffect);
		}

		return {
			Entity = _entity,
			original_getTile = original_getTile,
			DestTile = destTile,
			DestTerrainEffect = destTerrainEffect,
			CurrTerrainEffect = currTerrainEffect,
			CurrTerrainEffectIdx = currTerrainEffectIdx,
			// Will contain a list of actors whose skill_container.update() was called
			// during fetching the hit-chances during preview with the changes above.
			// We will need to update them again during cleanup.
			ActorsToUpdate = []
		};
	}}.RF_applyMovementPreview;

	// Between the two preview updates we must clean up all the switcheroos and other
	// data injections we made for the previewing entity. This function reverses all the
	// changes made in the RF_applyMovementPreview function.
	q.RF_cleanupMovementPreview <- { function RF_cleanupMovementPreview( _tag )
	{
		local entity = _tag.Entity;
		entity.getTile = _tag.original_getTile;

		local destTile = _tag.DestTile;
		destTile.Properties.remove("RF_PreviewEntity");
		destTile.Properties.remove("RF_PreviewZOCFaction");
		foreach (t in ::MSU.Tile.getNeighbors(destTile))
		{
			t.Properties.remove("RF_PreviewZOCFaction");
		}

		local destTerrainEffect = _tag.DestTerrainEffect;
		if (destTerrainEffect != null)
		{
			local skills = entity.getSkills().m.Skills;
			for (local i = skills.len() - 1; i >= 0; i--)
			{
				if (skills[i] == destTerrainEffect)
				{
					skills.remove(i);
					break;
				}
			}
		}

		if (_tag.CurrTerrainEffect != null)
		{
			entity.getSkills().m.Skills.insert(_tag.CurrTerrainEffectIdx, _tag.CurrTerrainEffect);
		}

		foreach (a in _tag.ActorsToUpdate)
		{
			a.getSkills().update();
		}
	}}.RF_cleanupMovementPreview;

	// Returns tooltip entries for predicted chances to hit and
	// to be hit at the previewed destination tile.
	q.RF_getHitchancesAtDestination <- { function RF_getHitchancesAtDestination( _tag, _cleanupFunc )
	{
		local ret = [];

		local entity = _tag.Entity;
		local destTile = _tag.DestTile;

		// Add tooltip about zone of control attacks at the ending tile (e.g. spearwall attacks from opponents)
		if (!entity.getCurrentProperties().IsImmuneToZoneOfControl && (destTile.Properties.Effect == null || destTile.Properties.Effect.Type != "smoke"))
		{
			local spearwallAttacks = ::Tactical.Entities.getAdjacentActors(entity.getPreviewMovement().End)
									.filter(@(_, _a) !_a.isAlliedWith(entity) && _a.onMovementInZoneOfControl(entity, true))
									.map(function(_a) {
										local aoo = _a.getSkills().getAttackOfOpportunity();
										return {
											id = 100,	type = "text",	icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedEntityImage(_a)),
											text = ::MSU.Text.colorNegative(aoo.getHitchance(entity) + "%") + " chance to hit with " + ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedSkillName(aoo, "entityId:" + _a.getID()))
										}
									});


			if (spearwallAttacks.len() != 0)
			{
				ret.push({
					id = 101,
					type = "text",
					icon = "ui/icons/warning.png",
					text = ::MSU.Text.colorNegative("Will be attacked on arrival by:"),
					children = spearwallAttacks
				});
			}
		}

		// Below we add tooltip about chances to hit valid targets and to be hit from opponents assuming we are at the destination tile.

		local myAttacks = entity.getSkills().getAllSkillsOfType(::Const.SkillType.Active).filter(@(_, _a) _a.isAttack());
		local myVision = entity.getCurrentProperties().getVision();
		local extraData = "entityId: " + entity.getID();

		local attacks = [];
		local collapseThreshold = ::Reforged.Mod.ModSettings.getSetting("TacticalTooltip_ThreatHitchanceThreshold").getValue();
		local attacksBelowThreshold = "";

		foreach (enemy in ::Tactical.Entities.getAllInstancesAsArray().filter(@(_, _a) !_a.isAlliedWith(entity) && !_a.isHiddenToPlayer()))
		{
			local text = "";
			local score = 0;
			foreach (a in myAttacks)
			{
				if (a.isUsable() && a.isInRange(enemy.getTile()) && (!a.isVisibleTileNeeded() || destTile.hasLineOfSightTo(enemy.getTile(), myVision)))
				{
					local hitChance = a.getHitchance(entity);
					score = 999 + hitChance;
					text = format("%s with %s", ::MSU.Text.colorPositive(a.getHitchance(enemy) + "%"), ::Reforged.NestedTooltips.getNestedSkillName(a, extraData));
					break;
				}
			}

			foreach (enemyAttack in enemy.getSkills().getAllSkillsOfType(::Const.SkillType.Active).filter(@(_, _a) _a.isAttack()))
			{
				if (enemyAttack.isUsable() && enemyAttack.isInRange(destTile) && (!enemyAttack.isVisibleTileNeeded() || enemy.getTile().hasLineOfSightTo(destTile, enemy.getCurrentProperties().getVision())))
				{
					// We update the skills of the enemy so that it sets the correct properties
					// with the previewing entity being considered at the destTile. During cleanup
					// we will have to do another update on these enemies to set them back to the
					// correct properties.
					enemy.getSkills().update();
					_tag.ActorsToUpdate.push(enemy);

					local hitChance = enemyAttack.getHitchance(entity);
					if (text == "" && hitChance <= collapseThreshold)
					{
						attacksBelowThreshold += ::Reforged.NestedTooltips.getNestedEntityImage(enemy);
					}
					else
					{
						score += hitChance;
						text += text == "" ? "" : ", ";
						text += format("%s with %s", ::MSU.Text.colorNegative(hitChance + "%"), ::Reforged.NestedTooltips.getNestedSkillName(enemyAttack, "entityId: " + enemy.getID()));
					}
					break;
				}
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
				text = "Opponents with hitchance below " + ::MSU.Text.colorNegative(collapseThreshold + "%")
				children = [{ id = 100, type = "text", text = ::Reforged.Mod.Tooltips.parseString(attacksBelowThreshold) }]
			});
		}

		_cleanupFunc(_tag);
		return ret;
	}}.RF_getHitchancesAtDestination;

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
