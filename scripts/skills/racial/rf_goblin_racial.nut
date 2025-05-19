this.rf_goblin_racial <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.rf_goblin";
		this.m.Name = "Goblin";
		this.m.Description = "This character is a goblin.";
		this.m.Icon = "ui/orientation/goblin_01_orientation.png";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The range of [throw net|Skill+throw_net] is increased by 1 up to a maximum of 3 tiles")
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		local throwNet = this.getContainer().getSkillByID("actives.throw_net");
		if (throwNet != null && throwNet.m.MaxRange < 3)
		{
			throwNet.m.MaxRange += 1;
		}
	}
});
