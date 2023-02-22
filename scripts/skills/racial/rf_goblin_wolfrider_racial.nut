this.rf_goblin_wolfrider <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.rf_goblin_wolfrider";
		this.m.Name = "Wolfrider";
		this.m.Description = "This character is riding a wolf, which makes using weapons a little harder than usual.";
		this.m.Icon = "";
		this.m.Type = ::Const.SkillType.Racial | ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/ammo.png",
			text = format("Weapon skills cost %s Action Point", ::MSU.Text.colorRed("+1"));
		});
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
