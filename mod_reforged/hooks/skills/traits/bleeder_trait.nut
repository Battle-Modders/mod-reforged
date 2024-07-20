::Reforged.HooksMod.hook("scripts/skills/traits/bleeder_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character is prone to bleeding and will do so more than most others."; // "more than" as opposed to vanilla "longer than"
		this.m.PerkTreeMultipliers = {
			"pg.rf_vigorous": 0
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		foreach (entry in ret)
		{
			if (entry.id == 10)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString("Will receive " + ::MSU.Text.colorNegative("double") + " damage from [Bleeding|Skill+bleeding_effect]");
				break;
			}
		}
		return ret;
	}
});
