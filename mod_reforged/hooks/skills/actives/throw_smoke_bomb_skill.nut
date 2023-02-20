::mods_hookExactClass("skills/actives/throw_smoke_bomb_skill", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
        foreach (index, entry in ret)
        {
            if (entry.id != 5) continue;
			if (entry.text.find("Increases Ranged Defense by ") == null) continue;	// Vanilla has two entries with id 5. That's why we check for a phrase aswell
			ret.remove(index);	// We remove that entry because we want to split it into two seperate entries that are next to each other
			break;
		}

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "Reduces Ranged Skill by " + ::MSU.Text.colorRed("50%") + " for anyone inside"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "Increases Ranged Defense by " + ::MSU.Text.colorGreen("30") + " for anyone inside"
			}
		]);

        return ret;
	}
});
