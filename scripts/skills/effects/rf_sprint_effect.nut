this.rf_sprint_effect <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueMult = 1.0
	},
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

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::MSU.Text.colorPositive(-1) + " Action Points spent per tile traveled"
		});

		if (this.m.FatigueMult != 1.0)
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorizeMult(this.m.FatigueMult, {InvertColor = true, AddSign = true}) + " Fatigue built per tile traveled"
			});
		}

		tooltip.push({
			id = 12,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorNegative("Will expire upon using any skill")
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MovementAPCostAdditional -= 1;
		_properties.MovementFatigueCostMult *= this.m.FatigueMult;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});

