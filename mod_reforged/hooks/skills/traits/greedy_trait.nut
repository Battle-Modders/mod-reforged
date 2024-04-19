::Reforged.HooksMod.hook("scripts/skills/traits/greedy_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0.5,
			"pg.rf_vicious": 2
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = ::MSU.Text.colorNegative("15%") + " more Daily wage"
		});
		return ret;
	}
});
