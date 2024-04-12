::Reforged.HooksMod.hook("scripts/skills/actives/cleave", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 8 && entry.text.find("bleeding damage per turn") != null)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString("Inflicts stacking [Bleeding|Skill+bleeding_effect] for additional damage");
				break;
			}
		}
		return ret;
	}
});
