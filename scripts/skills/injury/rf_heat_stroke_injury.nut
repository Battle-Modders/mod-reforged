this.rf_heat_stroke_injury <- ::inherit("scripts/skills/injury/injury", {
	m = {
		FatigueEffectMult = 1.25
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.rf_heat_stroke";
		this.m.Name = "Heat Stroke";
		this.m.Description = "Being exposed to intense heat caused this character\'s body temperature to soar to dangerous levels.";
		this.m.Type = this.m.Type | ::Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "rf_heatstroke_injury";
		this.m.Icon = "ui/injury/rf_heatstroke_injury.png";
		this.m.IconMini = "rf_heatstroke_injury_mini";
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.FatigueEffectMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.FatigueEffectMult, {InvertColor = true}) + " more [Fatigue|Concept.Fatigue] built")
			});
		}

		this.addTooltipHint(ret);	// Injury Specific additional tooltips

		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (!_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
		{
			return;
		}

		_properties.FatigueEffectMult *= this.m.FatigueEffectMult;
	}
});
