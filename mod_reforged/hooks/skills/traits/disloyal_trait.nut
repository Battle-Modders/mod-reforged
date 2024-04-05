::Reforged.HooksMod.hook("scripts/skills/traits/disloyal_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.special.rf_leadership": 0
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "Chance to desert on low mood is increased by " + ::MSU.Text.colorRed("100%")
		})
		return ret;
	}
});
