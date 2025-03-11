::Reforged.HooksMod.hook("scripts/skills/actives/pound", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		foreach (entry in ret)
		{
			// Improve the vanilla entry about ignoring Shields to also mention Shieldwall
			if (entry.id == 8)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString(format("Ignores the bonus to [Melee Defense|Concept.MeleeDefense] granted by shields %s[Shieldwall|Skill+shieldwall_effect]", this.m.IsShieldwallRelevant ? "but not by " : "and "));
				break;
			}
		}

		return ret;
	}
});
