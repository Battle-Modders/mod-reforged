::Reforged.HooksMod.hook("scripts/skills/effects/possessed_undead_effect", function(q) {
	q.create = @(__original) function()
	{
		__original();
        this.m.Description = "This character is possessed until the end of their turn."
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
                icon = "ui/icons/action_points.png",
				text = "Maximum Action Points are set to " + ::MSU.Text.colorGreen("12")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::MSU.Text.colorGreen("+15") + " Melee Skill"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorGreen("+10") + " Melee Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorGreen("+10") + " Ranged Defense"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::MSU.Text.colorGreen("+15") + " Resolve"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::MSU.Text.colorGreen("+50") + " Initiative"
			},
			{
				id = 10,
				type = "text",
                icon = "ui/icons/special.png",
				text = "All damage received is reduced by " + ::MSU.Text.colorRed("25%")
			}
		]);
		return ret;
	}
});
