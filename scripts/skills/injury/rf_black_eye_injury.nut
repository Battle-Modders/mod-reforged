this.rf_black_eye_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {
		VisionModifier = -1,
		MeleeSkillMult = 0.9,
		RangedSkillMult = 0.9,
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.rf_black_eye";
		this.m.Name = "Black Eye";
		this.m.Description = "A powerful blow to the eye socket left the area bruised, swollen, and discolored.";
		this.m.Type = this.m.Type | ::Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_43";		// TODO
		this.m.Icon = "ui/injury/injury_icon_43.png";		// TODO
		this.m.IconMini = "injury_icon_43_mini";		// TODO
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 3;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.VisionModifier != 0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = ::MSU.Text.colorRed(this.m.VisionModifier) + " Vision"
			});
		}

		if (this.m.MeleeSkillMult != 1.0)
		{
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::MSU.Text.colorizeMult(this.m.MeleeSkillMult, {AddSign = true}) + " Melee Skill"
			});
		}

		if (this.m.RangedSkillMult != 1.0)
		{
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::MSU.Text.colorizeMult(this.m.RangedSkillMult, {AddSign = true}) + " Ranged Skill"
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

		_properties.Vision += this.m.VisionModifier;
		_properties.MeleeSkillMult *= this.m.MeleeSkillMult;
		_properties.RangedSkillMult *= this.m.RangedSkillMult;
	}

});

