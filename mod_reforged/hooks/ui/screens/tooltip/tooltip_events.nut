::mods_hookNewObject("ui/screens/tooltip/tooltip_events", function(o) {
	local general_queryUIElementTooltipData = o.general_queryUIElementTooltipData;
	o.general_queryUIElementTooltipData = function( _entityId, _elementId, _elementOwner )
	{
        local entity = (_entityId == null) ? null : ::Tactical.getEntityByID(_entityId);

        if (entity == null) return general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);

        local ret = general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);

        if (_elementId == "character-stats.MeleeSkill")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
                    icon = "/ui/icons/melee_skill.png",
					text = "Base: " + entity.getBaseProperties().MeleeSkill
				},
				{

					id = 4,
					type = "text",
                    icon = "/ui/icons/melee_skill.png",
					text = "Bonus: " + (entity.getCurrentProperties().getMeleeSkill() - entity.getBaseProperties().MeleeSkill)
				}/*,
				{

					id = 5,
					type = "text",
			        icon = "/ui/icons/melee_skill.png",
					text = "Multiplier: " + entity.getBaseProperties().MeleeSkillMult
				}*/
			]);
        }

        if (_elementId == "character-stats.RangeSkill")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
			        icon = "/ui/icons/ranged_skill.png",
					text = "Base: " + entity.getBaseProperties().RangedSkill
				},
				{

					id = 4,
					type = "text",
			        icon = "/ui/icons/ranged_skill.png",
					text = "Bonus: " + (entity.getCurrentProperties().getRangedSkill() - entity.getBaseProperties().RangedSkill)
				}
			]);
        }

        if (_elementId == "character-stats.MeleeDefense")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
			        icon = "/ui/icons/melee_defense.png",
					text = "Base: " + entity.getBaseProperties().MeleeDefense
				},
				{

					id = 4,
					type = "text",
			        icon = "/ui/icons/melee_defense.png",
					text = "Bonus: " + (entity.getCurrentProperties().getMeleeDefense() - entity.getBaseProperties().MeleeDefense)
				}
			]);
        }

        if (_elementId == "character-stats.RangeDefense")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
                    icon = "/ui/icons/ranged_defense.png",
					text = "Base: " + entity.getBaseProperties().RangedDefense
				},
				{

					id = 4,
					type = "text",
                    icon = "/ui/icons/ranged_defense.png",
					text = "Bonus: " + (entity.getCurrentProperties().getRangedDefense() - entity.getBaseProperties().RangedDefense)
				}
			]);
        }

        if (_elementId == "character-stats.Hitpoints")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
                    icon = "ui/icons/health.png",
					text = "Base: " + entity.getBaseProperties().Hitpoints
				},
				{

					id = 4,
					type = "text",
                    icon = "ui/icons/health.png",
					text = "Bonus: " + (entity.getHitpointsMax() - entity.getBaseProperties().Hitpoints)
				}
			]);
        }

        if (_elementId == "character-stats.Fatigue")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
                    icon = "ui/icons/fatigue.png",
					text = "Base: " + entity.getBaseProperties().Stamina
				},
				{

					id = 4,
					type = "text",
                    icon = "ui/icons/fatigue.png",
					text = "Bonus: " + (entity.getCurrentProperties().getStamina() - entity.getBaseProperties().Stamina)
				},
				{

					id = 8,
					type = "text",
                    icon = "ui/icons/fatigue.png",
					text = "Fatigue Recovery: " + entity.getCurrentProperties().FatigueRecoveryRate
				},
				{

					id = 6,
					type = "text",
                    icon = "ui/icons/bag.png",
					text = ::Reforged.Mod.Tooltips.parseString("[Base Weight|Concept.Weight]: " + entity.getCurrentProperties().getRawWeight())
				},
				{

					id = 7,
					type = "text",
                    icon = "ui/icons/bag.png",
					text = ::Reforged.Mod.Tooltips.parseString("[Current Weight|Concept.Weight]: " + entity.getWeight())
				}
			]);
        }

        if (_elementId == "character-stats.Initiative")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
                    icon = "ui/icons/initiative.png",
					text = "Base: " + entity.getBaseProperties().Initiative
				},
				{

					id = 4,
					type = "text",
                    icon = "ui/icons/initiative.png",
					text = "Bonus: " + (entity.getCurrentProperties().getInitiative() - entity.getBaseProperties().Initiative)
				},
				{
					id = 6,
					type = "text",
                    icon = "ui/icons/bag.png",
					text = ::Reforged.Mod.Tooltips.parseString("[Burden|Concept.Burden]: " + entity.getBurden())
				}
			]);
        }

        if (_elementId == "character-stats.Bravery")
        {
			ret.extend([
				{

					id = 3,
					type = "text",
                    icon = "ui/icons/bravery.png",
					text = "Base: " + entity.getBaseProperties().Bravery
				},
				{

					id = 4,
					type = "text",
                    icon = "ui/icons/bravery.png",
					text = "Bonus: " + (entity.getCurrentProperties().getBravery() - entity.getBaseProperties().Bravery)
				}
			]);
        }

		return ret;
	}
});
