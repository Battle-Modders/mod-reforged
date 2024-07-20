this.rf_orc_racial <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.rf_orc";
		this.m.Name = "Orc";
		this.m.Description = "This character is an orc.";
		this.m.Icon = "ui/orientation/orc_02_orientation.png";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The [threshold|Concept.InjuryThreshold] to sustain [injuries|Concept.InjuryTemporary] on getting hit is increased by " + ::MSU.Text.colorPositive("25%"))
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.ThresholdToReceiveInjuryMult *= 1.25;
	}
});
