::Reforged.HooksMod.hook("scripts/skills/effects/possessed_undead_effect", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character is possessed until the end of their [turn.|Concept.Turn]")
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("Maximum [Action Points|Concept.ActionPoints] are set to " + ::MSU.Text.colorPositive("12"))
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+15") + " [Melee Skill|Concept.MeleeSkill]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+10") + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+10") + " [Ranged Defense|Concept.RangeDefense]")
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+15") + " [Resolve|Concept.Bravery]")
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+50") + " [Initiative|Concept.Initiative]")
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "All damage received is reduced by " + ::MSU.Text.colorNegative("25%")
			}
		]);
		return ret;
	}
});
