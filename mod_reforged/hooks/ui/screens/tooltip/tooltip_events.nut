::Reforged.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
	// Add info about potential attacks of opportunity during movement preview
	q.tactical_queryTileTooltipData = @(__original) { function tactical_queryTileTooltipData()
	{
		local ret = __original();
		if (ret != null)
		{
			ret.extend(this.RF_getZOCAttackTooltip(::Tactical.TurnSequenceBar.getActiveEntity()));
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
						text = ::Reforged.Mod.Tooltips.parseString("Characters gain experience in battle and if a character has accumulated sufficient experience, he\'ll [level up.|Concept.Level]\n\nExperience is gained upon an enemy\'s death, no matter what caused the death, as long as your company dealt some damage to that enemy, and is proportional to the fraction of the total damage dealt to that enemy by your company. Of this experience, " + (::Const.XP.XPForKillerPct * 100) + "% is shared proportionally between the brothers who did damage. The other " + (100 - ::Const.XP.XPForKillerPct * 100) + "% is shared equally among all members of the company.")
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
							entry.text = ::String.replace(entry.text, "See also: Morale.", ::Reforged.Mod.Tooltips.parseString("See also: [Morale.|Concept.Morale]"));
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
								entry.text += " Each point of [current|Concept.CurrentAttribute] defense above " + ::Const.Tactical.Settings.AttributeDefenseSoftCap + " counts as half a point.";
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
	q.RF_getZOCAttackTooltip <- { function RF_getZOCAttackTooltip( _entity )
	{
		if (_entity == null || _entity.getPreviewMovement() == null || _entity.getCurrentProperties().IsImmuneToZoneOfControl)
			return [];

		local ret = [];

		// Add tooltip about zone of control attacks at the starting tile
		if (_entity.getTile().Properties.Effect == null || _entity.getTile().Properties.Effect.Type != "smoke")
		{
			local attacks = ::Tactical.Entities.getAdjacentActors(_entity.getTile()).filter(@(_, _a) !_a.isAlliedWith(_entity) && _a.onMovementInZoneOfControl(_entity, false))
							.map(@(_a) {
								id = 100,	type = "text",	icon = "ui/orientation/" + _a.getOverlayImage() + ".png",
								text = ::MSU.Text.colorNegative(_a.getSkills().getAttackOfOpportunity().getHitchance(_entity) + "%") + " chance to hit"
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

		// Add tooltip about zone of control attacks at the ending tile (e.g. spearwall attacks from opponents)
		if (_entity.getPreviewMovement().End.Properties.Effect == null || _entity.getPreviewMovement().End.Properties.Effect.Type != "smoke")
		{
			local spearwallAttacks = ::Tactical.Entities.getAdjacentActors(_entity.getPreviewMovement().End).filter(@(_, _a) !_a.isAlliedWith(_entity) && _a.onMovementInZoneOfControl(_entity, true))
									.map(@(_a) {
										id = 100,	type = "text",	icon = "ui/orientation/" + _a.getOverlayImage() + ".png",
										text = ::MSU.Text.colorNegative(_a.getSkills().getAttackOfOpportunity().getHitchance(_entity) + "%") + " chance to hit"
									});

			if (spearwallAttacks.len() != 0)
			{
				ret.push({
					id = 101,
					type = "text",
					icon = "ui/icons/warning.png",
					text = ::MSU.Text.colorNegative("Will be attacked on arrival by: "),
					children = spearwallAttacks
				});
			}
		}

		return ret;
	}}.RF_getZOCAttackTooltip;

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
						text = ::Reforged.Mod.Tooltips.parseString("[Ignore when attacking:|Concept.ReachIgnoreOffensive] ") + ::MSU.Text.colorizeValue(entity.getCurrentProperties().OffensiveReachIgnore)
					},
					{
						id = 6,	type = "text",	icon = "ui/icons/rf_reach_defense.png",
						text = ::Reforged.Mod.Tooltips.parseString("[Ignore when defending:|Concept.ReachIgnoreDefensive] ") + ::MSU.Text.colorizeValue(entity.getCurrentProperties().DefensiveReachIgnore)
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
