this.rf_worn_down_effect <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueCostMult = 1.1,
		InitiativeMult = 0.9
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
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::MSU.Text.colorizeMult(this.m.FatigueCostMult, {InvertColor = true}) + " increased Fatigue built"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorizeMult(this.m.InitiativeMult) + " reduced Initiative"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueEffectMult *= this.m.FatigueCostMult;
		_properties.InitiativeMult *= this.m.InitiativeMult;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
