::Reforged.HooksMod.hook("scripts/skills/actives/flail_skill", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (entry in ret)
		{
			// Improve the vanilla entry about ignoring Shields to also mention Shieldwall
			if (entry.id == 7)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString(format("Ignores the bonus to [Melee Defense|Concept.MeleeDefense] granted by shields but not by [Shieldwall|Skill+shieldwall_effect]"));
				break;
			}
		}

		return ret;
	}
});
