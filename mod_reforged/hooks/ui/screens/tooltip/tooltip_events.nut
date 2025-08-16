::Reforged.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
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
						text = ::Reforged.Mod.Tooltips.parseString("Characters gain experience as they or their allies slay enemies in battles. If a character has accumulated sufficient experience, he\'ll [level up.|Concept.Level]\n\nExperience gained from dying enemies is proportional to the fraction of the total damage dealt to that enemy by your company. Of this experience, " + (::Const.XP.XPForKillerPct * 100) + "% is shared proportionally between the brothers who did damage. The other " + (100 - ::Const.XP.XPForKillerPct * 100) + "% is shared equally among all members of the company.")
					}
				];

			case "character-screen.left-panel-header-module.Level":
				return [
					{
						id = 1,
						type = "title",
						text = "Level"
					},
					{
						id = 2,
						type = "description",
						text = ::Reforged.Mod.Tooltips.parseString("The character\'s level measures [experience|Concept.Experience] in battle. Characters rise in levels as they gain experience and are able to increase their [attributes|Concept.CharacterAttribute] and gain [perks|Concept.Perk] that make them better at the mercenary profession.\n\nBeyond the " + ::Const.XP.MaxLevelWithPerkpoints + "th character level, characters are veterans and gain perk points " + (::Reforged.Config.VeteranPerksLevelStep == 1 ? "" : "only") + " every " + ::Reforged.Config.VeteranPerksLevelStep + "th level. They can still improve their attributes but the attribute gain per level is small.")
					}
				];
		}

		// Extending
		local ret = __original(_entityId, _elementId, _elementOwner);

		if (ret != null)
		{
			if (_elementId == "character-stats.Bravery")
			{
				foreach (entry in ret)
				{
					if (entry.id == 2 && entry.type == "description")
					{
						entry.text = ::String.replace(entry.text, "See also: Morale.", ::Reforged.Mod.Tooltips.parseString("See also: [Morale.|Concept.Morale]"));
						break;
					}
				}
			}

			ret.extend(this.getBaseAttributesTooltip(_entityId, _elementId, _elementOwner));
		}

		return ret;
	}}.general_queryUIElementTooltipData;

// New Functions
	q.getBaseAttributesTooltip <- { function getBaseAttributesTooltip( _entityId, _elementId, _elementOwner )
	{
		local entity = _entityId == null ? null : ::Tactical.getEntityByID(_entityId);
		if (entity == null || entity == ::MSU.getDummyPlayer())
		{
			return [];
		}

		// Manually look for all attribute IDs and generate the respective tooltip entries
		switch( _elementId )
		{
			case "character-stats.MeleeSkill":
				return [
					{
						id = 3,
						type = "text",
						icon = "/ui/icons/melee_skill.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().MeleeSkill)
					},
					{
						id = 4,
						type = "text",
						icon = "/ui/icons/melee_skill.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getMeleeSkill() - entity.getBaseProperties().MeleeSkill, {AddSign = true})
					}
				];
			case "character-stats.RangeSkill":
				return [
					{
						id = 3,
						type = "text",
						icon = "/ui/icons/ranged_skill.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().RangedSkill)
					},
					{
						id = 4,
						type = "text",
						icon = "/ui/icons/ranged_skill.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getRangedSkill() - entity.getBaseProperties().RangedSkill, {AddSign = true})
					}
				];
			case "character-stats.MeleeDefense":
				return [
					{
						id = 3,
						type = "text",
						icon = "/ui/icons/melee_defense.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().MeleeDefense, {AddSign = entity.getBaseProperties().MeleeDefense < 0})
					},
					{
						id = 4,
						type = "text",
						icon = "/ui/icons/melee_defense.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getMeleeDefense() - entity.getBaseProperties().MeleeDefense, {AddSign = true})
					}
				];
			case "character-stats.RangeDefense":
				return [
					{
						id = 3,
						type = "text",
						icon = "/ui/icons/ranged_defense.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().RangedDefense, {AddSign = entity.getBaseProperties().RangedDefense < 0})
					},
					{
						id = 4,
						type = "text",
						icon = "/ui/icons/ranged_defense.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getRangedDefense() - entity.getBaseProperties().RangedDefense, {AddSign = true})
					}
				];
			case "character-stats.Hitpoints":
				return [
					{
						id = 3,
						type = "text",
						icon = "ui/icons/health.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Hitpoints)
					},
					{
						id = 4,
						type = "text",
						icon = "ui/icons/health.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getHitpointsMax() - entity.getBaseProperties().Hitpoints, {AddSign = true})
					}
				];
			case "character-stats.Fatigue":
				return [
					{
						id = 3,
						type = "text",
						icon = "ui/icons/fatigue.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Stamina)
					},
					{
						id = 4,
						type = "text",
						icon = "ui/icons/fatigue.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getFatigueMax() - entity.getBaseProperties().Stamina, {AddSign = true})
					},
					{

						id = 5,
						type = "text",
						icon = "ui/icons/fatigue.png",
						text = "Fatigue Recovery: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getFatigueRecoveryRate(), {AddSign = true})
					},
					{
						id = 6,
						type = "text",
						icon = "ui/icons/bag.png",
						text = "Item Weight: " + ::MSU.Text.colorNegative(::Math.abs(-1 * entity.getItems().getStaminaModifier()))
					}
				];
			case "character-stats.Initiative":
				return [
					{
						id = 3,
						type = "text",
						icon = "ui/icons/initiative.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Initiative)
					},
					{
						id = 4,
						type = "text",
						icon = "ui/icons/initiative.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getInitiative() - entity.getBaseProperties().Initiative, {AddSign = true})
					}
				];
			case "character-stats.Bravery":
				return [
					{
						id = 3,
						type = "text",
						icon = "ui/icons/bravery.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Bravery)
					},
					{
						id = 4,
						type = "text",
						icon = "ui/icons/bravery.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getBravery() - entity.getBaseProperties().Bravery, {AddSign = true})
					}
				];
			case "Concept.Reach":
				local weapon = entity.getMainhandItem();
				local weaponReach = weapon == null ? 0 : weapon.getReach();
				local reachModifier = entity.getCurrentProperties().getReach() - entity.getBaseProperties().Reach - weaponReach;
				return [
					{
						id = 3,
						type = "text",
						icon = "ui/icons/rf_reach.png",
						text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Reach)
					},
					{
						id = 3,
						type = "text",
						icon = "ui/icons/rf_reach.png",
						text = "Weapon: " + ::MSU.Text.colorizeValue(weaponReach)
					},
					{
						id = 3,
						type = "text",
						icon = "ui/icons/rf_reach.png",
						text = "Modifier: " + ::MSU.Text.colorizeValue(reachModifier, {AddSign = true})
					},
					{
						id = 4,
						type = "text",
						icon = "ui/icons/rf_reach_attack.png",
						text = "Offensive: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().OffensiveReachIgnore, {AddSign = true})
					},
					{
						id = 5,
						type = "text",
						icon = "ui/icons/rf_reach_defense.png",
						text = "Defensive: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().DefensiveReachIgnore, {AddSign = true})
					}
				];
		}

		return [];
	}}.getBaseAttributesTooltip;
});
