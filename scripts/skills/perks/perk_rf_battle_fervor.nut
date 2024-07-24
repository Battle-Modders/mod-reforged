this.perk_rf_battle_fervor <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_battle_fervor";
		this.m.Name = ::Const.Strings.PerkName.RF_BattleFervor;
		this.m.Description = "This character will stop at nothing short of absolute victory.";
		this.m.Icon = "ui/perks/perk_rf_battle_fervor.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local isConfident = this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Confident;

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive((isConfident ? 20 : 10) + "%") + " more [Resolve|Concept.Bravery]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+" + (isConfident ? 20 : 10)) + " [Resolve|Concept.Bravery] at positive [morale checks|Concept.Morale]")
			}
		]);

		if (isConfident)
		{
			ret.extend([
				{
					id = 12,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("5%") + " more [Melee Skill|Concept.MeleeSkill]")
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("5%") + " more [Ranged Skill|Concept.RangeSkill]")
				},
				{
					id = 14,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("5%") + " more [Melee Defense|Concept.MeleeDefense]")
				},
				{
					id = 15,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("5%") + " more [Ranged Defense|Concept.RangeDefense]")
				}
			]);
		}

		return ret;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Confident)
		{
			_properties.BraveryMult *= 1.2;
			_properties.MeleeSkillMult *= 1.05;
			_properties.RangedSkillMult *= 1.05;
			_properties.MeleeDefenseMult *= 1.05;
			_properties.RangedDefenseMult *= 1.05;
			foreach (moraleCheckType in ::Const.MoraleCheckType)
			{
				_properties.PositiveMoraleCheckBravery[moraleCheckType] += 20;
			}
		}
		else
		{
			_properties.BraveryMult *= 1.1;
			foreach (moraleCheckType in ::Const.MoraleCheckType)
			{
				_properties.PositiveMoraleCheckBravery[moraleCheckType] += 10;
			}
		}
	}
});
