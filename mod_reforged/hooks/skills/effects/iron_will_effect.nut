::Reforged.HooksMod.hook("scripts/skills/effects/iron_will_effect", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		foreach (entry in ret)
		{
			if (entry.id == 11)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString("Not affected by, and cannot receive, [temporary injuries|Concept.InjuryTemporary]");
				break;
			}
		}

		return ret;
	}}.getTooltip;
});
