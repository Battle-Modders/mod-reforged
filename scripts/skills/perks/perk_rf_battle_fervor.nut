this.perk_rf_battle_fervor <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_battle_fervor";
		this.m.Name = ::Const.Strings.PerkName.RF_BattleFervor;
		this.m.Description = "This character will stop at nothing short of absolute victory.";
		this.m.Icon = "ui/perks/rf_battle_fervor.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local isConfident = this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Confident;

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + (isConfident ? 20 : 10) + "%[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Additional [color=" + ::Const.UI.Color.PositiveValue + "]+" + (isConfident ? 20 : 10) + "[/color] Resolve at positive morale checks"
			}
		]);

		if (isConfident)
		{
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] Melee Skill"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] Ranged Skill"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] Melee Defense"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] Ranged Defense"
				}
			]);
		}

		return tooltip;
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
