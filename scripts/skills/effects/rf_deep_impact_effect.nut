this.rf_deep_impact_effect <- ::inherit("scripts/skills/skill", {
	m = {
		// Both of these need to be set externally when the effect is added
		SkillMult = 1.0
		DamageTotalMult = 1.0,

		MultMin = 0.5
	},
	function create()
	{
		this.m.ID = "effects.rf_deep_impact";
		this.m.Name = "Deep Impact";
		this.m.Description = "This character has received a very heavy blow, significantly reducing combat effectiveness.";
		this.m.Icon = "ui/perks/perk_rf_deep_impact.png";
		this.m.Overlay = "rf_deep_impact_effect";
		this.m.IconMini = "rf_deep_impact_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function setDamageTotalMult( _d )
	{
		this.m.DamageTotalMult = ::Math.minf(this.m.DamageTotalMult, ::Math.maxf(this.m.MultMin, _d));
	}

	function setSkillMult( _m )
	{
		this.m.SkillMult = ::Math.minf(this.m.SkillMult, ::Math.maxf(this.m.MultMin, _m));
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.getContainer().getActor().getID() == ::MSU.getDummyPlayer().getID())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString("Damage dealt, [Melee Skill|Concept.MeleeSkill], [Melee Defense|Concept.MeleeDefense], [Ranged Skill|Concept.RangeSkill] and [Ranged Defense|Concept.RangeDefense] are reduced by a percentage equal to the ratio of the [Hitpoints|Concept.Hitpoints] damage received to current [Hitpoints,|Concept.Hitpoints] up to a maximum of " + ::MSU.Text.colorizeMult(this.m.MultMin))
			});
		}
		else
		{
			if (this.m.DamageTotalMult != 1.0)
			{
				ret.push({
					id = 10,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = ::MSU.Text.colorizeMultWithText(this.m.DamageTotalMult) + " damage dealt"
				});
			}

			if (this.m.SkillMult != 1.0)
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.SkillMult) + " [Melee Skill|Concept.MeleeSkill]")
				});
				ret.push({
					id = 12,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.SkillMult) + " [Melee Defense|Concept.MeleeDefense]")
				});
				ret.push({
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.SkillMult) + " [Ranged Skill|Concept.RangeSkill]")
				});
				ret.push({
					id = 14,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.SkillMult) + " [Ranged Defense|Concept.RangeDefense]")
				});
			}
		}

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= this.m.DamageTotalMult;
		_properties.MeleeSkillMult *= this.m.SkillMult;
		_properties.MeleeDefenseMult *= this.m.SkillMult;
		_properties.RangedSkillMult *= this.m.SkillMult;
		_properties.RangedDefenseMult *= this.m.SkillMult;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
