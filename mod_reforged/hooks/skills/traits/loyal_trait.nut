::Reforged.HooksMod.hook("scripts/skills/traits/loyal_trait", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.PerkTreeMultipliers = {};
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 5,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = "Chance to desert on low mood is reduced by " + ::MSU.Text.colorGreen("50%")
		})
		return ret;
	}
});
