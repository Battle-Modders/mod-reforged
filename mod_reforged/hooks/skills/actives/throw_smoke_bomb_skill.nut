::Reforged.HooksMod.hook("scripts/skills/actives/throw_smoke_bomb_skill", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (index, entry in ret)
		{
			// Vanilla has two entries with id 5. That's why we check for a phrase aswell
			if (entry.id == 5 && entry.text.find("Increases Ranged Defense by ") != null)
			{
				ret.remove(index);	// We remove that entry because we want to split it into two seperate entries that are next to each other
				break;
			}
		}

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("50%") + " less [Ranged Skill|Concept.RangeSkill] for anyone inside")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+30") + " [Ranged Defense|Concept.RangeDefense] for anyone inside")
			}
		]);

		return ret;
	}
});
