this.rf_sprint_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_sprint";
		this.m.Name = "Sprinting";
		this.m.Description = "This character is running fast.";
		this.m.Icon = "skills/rf_sprint_effect.png";
		this.m.IconMini = "rf_sprint_effect_mini";
		this.m.Overlay = "rf_sprint_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::MSU.Text.colorGreen(-1) + " Action Points spent per tile traveled"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorRed("50%") + " more Fatigue built per tile traveled"
			}
		]);

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MovementAPCostAdditional -= 1;
		_properties.MovementFatigueCostMult *= 1.5;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});

