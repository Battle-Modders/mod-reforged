::Reforged.HooksMod.hook("scripts/skills/traits/loyal_trait", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/asset_money.png",
			text = ::MSU.Text.colorPositive("50%") + " less chance to desert on low mood"
		});
		return ret;
	}}.getTooltip;
});
