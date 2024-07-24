this.rf_goblin_wolfrider_racial <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.rf_goblin_wolfrider";
		this.m.Name = "Riding a Wolf";
		this.m.Description = "This character is riding a wolf, which makes using weapons a little harder than usual.";
		this.m.Icon = "ui/orientation/goblin_05_orientation.png";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+1") + " [Reach|Concept.Reach]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("Weapon skills cost " + ::MSU.Text.colorNegative("+1") + " [Action Point|Concept.ActionPoints]")
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Reach += 1;
	}

	function onAfterUpdate( _properties )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null) return;

		foreach (skill in weapon.getSkills())
		{
			skill.m.ActionPointCost += 1;
		}
	}
});
