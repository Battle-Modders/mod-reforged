this.rf_heat_stroke_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {
		FatigueCostMult = 1.25,
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.rf_heat_stroke";
		this.m.Name = "Heat Stroke";
		this.m.Description = "An intense heat caused the player\'s body temperature to soar to dangerous levels.";
		this.m.Type = this.m.Type | ::Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_43";		// TODO
		this.m.Icon = "ui/injury/injury_icon_43.png";		// TODO
		this.m.IconMini = "injury_icon_43_mini";		// TODO
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.FatigueCostMult != 1.0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorizeMult(this.m.FatigueCostMult, {InvertColor = true}) + " increased Fatigue built"
			});
		}

		this.addTooltipHint(tooltip);	// Injury Specific additional tooltips

		return tooltip;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (!_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
		{
			return;
		}

		_properties.FatigueEffectMult *= this.m.FatigueCostMult;
	}

});

