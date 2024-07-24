::Reforged.HooksMod.hook("scripts/items/accessory/iron_will_potion_item", function(q) {
	q.getTooltip = @(__original) function()
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
	}
});
