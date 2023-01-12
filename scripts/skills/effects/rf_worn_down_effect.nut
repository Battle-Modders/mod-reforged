this.rf_worn_down_effect <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueEffectIncrease = 10
	},
	function create()
	{
		this.m.ID = "effects.rf_worn_down";
		this.m.Name = "Worn Down";
		this.m.Description = "This character is feeling worn down after reciving rather tiring attacks.";
		this.m.Icon = "ui/perks/rf_wear_them_down.png";
		this.m.IconMini = "rf_worn_down_effect_mini";
		this.m.Overlay = "rf_worn_down_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]" + (1.0 + this.m.FatigueEffectIncrease * 0.01) + "%[/color] increased Fatigue built"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]" + (1.0 + this.m.FatigueEffectIncrease * 0.01) + "%[/color] reduced Initiative"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueEffectMult *= 1.0 + this.m.FatigueEffectIncrease * 0.01;
		_properties.InitiativeMult *= 1.0 - this.m.FatigueEffectIncrease * 0.01;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
