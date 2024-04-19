::Reforged.HooksMod.hook("scripts/skills/traits/disloyal_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {
			"pg.rf_devious": 2
		};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = ::MSU.Text.colorRed("100%") + " more chance to desert on low mood"
		});
		return ret;
	}
});
