::Reforged.HooksMod.hook("scripts/skills/actives/horror_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "Induces fear and terror in enemies, potentially rendering them horrified.";
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Trigger a negative Mental [Morale|Concept.Morale] Check with an additional penalty to [Resolve|Concept.Bravery] of " + ::MSU.Text.colorPositive("15"))
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If the target fails a Mental [Morale|Concept.Morale] Check with an additional penalty to [Resolve|Concept.Bravery] of " + ::MSU.Text.colorPositive("5") + ", apply [Horrified|Skill+horrified_effect] to it")
		});

		return ret;
	}


});
