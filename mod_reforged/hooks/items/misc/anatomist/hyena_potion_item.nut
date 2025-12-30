::Reforged.HooksMod.hook("scripts/items/misc/anatomist/hyena_potion_item", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 11)
			{
				// Replace vanilla tooltip which says 50% less damage to instead say all effects of bleeding are reduced
				// due to bleeding rework in Reforged.
				entry.text = ::Reforged.Mod.Tooltips.parseString("The effects of [$ $|Skill+bleeding_effect] are " + ::MSU.Text.colorPositive("halved"));
				break;
			}
		}
		return ret;
	}}.getTooltip;
});
