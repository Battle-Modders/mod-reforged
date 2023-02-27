::mods_hookExactClass("skills/actives/throw_smoke_bomb_skill", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
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
				text = ::MSU.Text.colorRed("50%") + " reduced Ranged Skill for anyone inside the smoke"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorGreen("+30") + " Ranged Defense for anyone inside the smoke"
			}
		]);

        return ret;
	}
});
