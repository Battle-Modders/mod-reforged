local generateExtendedAttributeStats = function( _entityId, _elementId, _elementOwner )
{
	local entity = (_entityId == null) ? null : ::Tactical.getEntityByID(_entityId);
	if (entity == null || entity == ::MSU.getDummyPlayer())
	{
		return [];
	}

	// Manually look for all attribute ID's and generate the respective tooltip entries
	switch( _elementId )
	{
		case "character-stats.MeleeSkill":
			return [
				{
					id = 3,
					type = "text",
					icon = "/ui/icons/melee_skill.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().MeleeSkill, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "/ui/icons/melee_skill.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getMeleeSkill() - entity.getBaseProperties().MeleeSkill)
				}
			];
		case "character-stats.RangeSkill":
			return [
				{
					id = 3,
					type = "text",
					icon = "/ui/icons/ranged_skill.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().RangedSkill, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "/ui/icons/ranged_skill.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getRangedSkill() - entity.getBaseProperties().RangedSkill)
				}
			];
		case "character-stats.MeleeDefense":
			return [
				{
					id = 3,
					type = "text",
					icon = "/ui/icons/melee_defense.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().MeleeDefense, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "/ui/icons/melee_defense.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getMeleeDefense() - entity.getBaseProperties().MeleeDefense)
				}
			];
		case "character-stats.RangeDefense":
			return [
				{
					id = 3,
					type = "text",
					icon = "/ui/icons/ranged_defense.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().RangedDefense, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "/ui/icons/ranged_defense.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getRangedDefense() - entity.getBaseProperties().RangedDefense)
				}
			];
		case "character-stats.Hitpoints":
			return [
				{
					id = 3,
					type = "text",
					icon = "ui/icons/health.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Hitpoints, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "ui/icons/health.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getHitpointsMax() - entity.getBaseProperties().Hitpoints)
				}
			];
		case "character-stats.Fatigue":
			return [
				{
					id = 3,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Stamina, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getFatigueMax() - entity.getBaseProperties().Stamina)
				},
				{

					id = 8,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Fatigue Recovery: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getFatigueRecovery())
				},
				{

					id = 6,
					type = "text",
					icon = "ui/icons/bag.png",
					text = "Total Weight: " + ::Math.abs(entity.getItems().getWeight())
				}
			];
		case "character-stats.Initiative":
			return [
				{
					id = 3,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Initiative, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getInitiative() - entity.getBaseProperties().Initiative)
				}
			];
		case "character-stats.Bravery":
			return [
				{
					id = 3,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "Base: " + ::MSU.Text.colorizeValue(entity.getBaseProperties().Bravery, {AddSign = false})
				},
				{
					id = 4,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "Modifier: " + ::MSU.Text.colorizeValue(entity.getCurrentProperties().getBravery() - entity.getBaseProperties().Bravery)
				}
			];
	}

	return [];
}

::Reforged.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
	q.general_queryUIElementTooltipData = @(__original) function( _entityId, _elementId, _elementOwner )
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

		ret.extend(generateExtendedAttributeStats(_entityId, _elementId, _elementOwner));

		return ret;
	}
});
